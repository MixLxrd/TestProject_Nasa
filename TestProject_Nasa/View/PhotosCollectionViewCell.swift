//
//  PhotosCollectionViewCell.swift
//  TestProject_Nasa
//
//  Created by Mike on 09.09.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.toAutoLayout()
        return activity
    }()
    
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}

extension PhotosCollectionViewCell {
    private func setupLayout() {
        addSubview(photoImageView)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        let constraints = [
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
