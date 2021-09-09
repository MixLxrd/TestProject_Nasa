//
//  DetailPhotoViewController.swift
//  TestProject_Nasa
//
//  Created by Mike on 09.09.2021.
//

import UIKit

class DetailPhotoViewController: UIViewController {

    lazy var albumsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
    
}

extension DetailPhotoViewController {
    private func setupLayout() {
        view.addSubview(albumsImageView)
        view.backgroundColor = .black
        let constraints = [
            albumsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            albumsImageView.topAnchor.constraint(equalTo: view.topAnchor),
            albumsImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
