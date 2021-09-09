//
//  PhotosViewController.swift
//  TestProject_Nasa
//
//  Created by Mike on 09.09.2021.
//

import UIKit

class PhotosViewController: UIViewController {

    let networkDataFetcher = NetworkDataFetcher()
    
    var photos: Photos? {
        didSet {
            fetchImages()
        }
    }
    
    var photosImages: [UIImage] = [] {
        didSet {
            photosCollectionView.reloadData()
        }
    }
    
    private lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        collectionView.toAutoLayout()
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkDataFetcher.fetchPhotos { response in
            guard let search = response else { return }
            self.photos = search
        }
        setupLayout()
    }

}

extension PhotosViewController {
    private func setupLayout() {
        view.addSubview(photosCollectionView)
        let constraints = [
            photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func fetchImages() {
        DispatchQueue.main.async {
            guard let photosNasa = self.photos?.photos else { return }
            for photo in photosNasa {
                let stringURL = photo.imgSrc
                let url = URL(string: stringURL)
                if let data = try? Data(contentsOf: url!) {
                    self.photosImages.append(UIImage(data: data)!)
                }
                print(self.photosImages.count)
            }
        }
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var offset: CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (UIScreen.main.bounds.width - offset * 4) / 2, height: (UIScreen.main.bounds.width - offset * 4) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        cell.photoImageView.image = photosImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = DetailPhotoViewController()
        vc.albumsImageView.image = photosImages[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
