//
//  PhotosViewModel.swift
//  TestProject_Nasa
//
//  Created by Mike on 09.09.2021.
//

import UIKit

class PhotosCollectionsViewModel {
    
    var countPhotos: Int {
        return photos?.photos.count ?? 0
    }
    
    let networkDataFetcher = NetworkDataFetcher()
    
    var photos: Photos? {
        didSet {
            reloadComplition?()
        }
    }
    
    var photosImages: [String:UIImage] = [:]
    
    var reloadComplition: (() -> Void)?
    
    //get json + parse to photos
    func fetchData() {
        networkDataFetcher.fetchPhotos { response in
            guard let search = response else { return }
            self.photos = search
        }
    }
    
    func fetchImages(index: Int, completion: @escaping (UIImage?) -> Void) {
        guard let stringURL = self.photos?.photos[index].imgSrc else { return }
        if let photo = self.photosImages[stringURL] {
            completion(photo)
        } else {
            networkDataFetcher.networkService.request(urlString: stringURL) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                    self?.photosImages[stringURL] = image
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    init() {
        fetchData()
    }
    
}
