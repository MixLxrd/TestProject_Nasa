//
//  PhotosViewController.swift
//  TestProject_Nasa
//
//  Created by Mike on 09.09.2021.
//

import UIKit

final class PhotosViewController: UIViewController {
    
    var viewModel: PhotosCollectionsViewModel
    
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
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
        view.backgroundColor = .blue
        setupLayout()
        viewModel.reloadComplition = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.photosCollectionView.reloadData()
            }
        }
        
    }
    
    init(viewModel: PhotosCollectionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotosViewController {
    private func setupLayout() {
        view.addSubview(photosCollectionView)
        photosCollectionView.addSubview(activityIndicator)
        activityIndicator.toAutoLayout()
        activityIndicator.startAnimating()
        let constraints = [
            photosCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: photosCollectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: photosCollectionView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
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
        return viewModel.countPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        viewModel.fetchImages(index: indexPath.row) { [weak cell] image in
            guard let image = image else { return }
            cell?.configureCell(image: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        /*
         let vc = DetailPhotoViewController()
         vc.albumsImageView.image = photosImages[indexPath.row]
         navigationController?.pushViewController(vc, animated: true)
         */
        
    }
    
    
}
