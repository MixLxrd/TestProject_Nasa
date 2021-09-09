//
//  PhotosViewModel.swift
//  TestProject_Nasa
//
//  Created by Mike on 09.09.2021.
//

import UIKit

class PhotosCollectionsViewModel {
    
    var countPhotos: Int {
        return photos.count
    }
    
    let networkDataFetcher = NetworkDataFetcher()
    
    var photos: [Photo] = [] {
        didSet {
            reloadComplition?()
        }
    }
    
    var photosImages: [String:UIImage] = [:] {
        didSet {
            //photosCollectionView.reloadData()
        }
    }
    
    var reloadComplition: (() -> Void)?
    //get json + parse to photos
    func fetchData() {
        networkDataFetcher.fetchPhotos { response in
            guard let search = response else { return }
            self.photos = search
        }
    }
    
    func fetchImages(index: Int, complition: @escaping (UIImage?) -> Void) {
        DispatchQueue.main.async {
            let stringURL = self.photos[index].imgSrc
            let url = URL(string: stringURL)
            if let data = try? Data(contentsOf: url!) {
                let image = UIImage(data: data)
                complition(image)
                self.photosImages[stringURL] = image
            }
        }
    }
    
    
    init() {
        fetchData()
    }
    
}
