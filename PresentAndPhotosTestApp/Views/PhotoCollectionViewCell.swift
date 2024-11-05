//
//  PhotoCollectionViewCell.swift
//  PresentAndPhotosTestApp
//
//  Created by Asya Checkanar on 04.11.2024.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    private var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    public func configure(image: UIImage) {
        photo.image = image
        setupUI()
        setConstraints()
    }
    private func setupUI() {
        contentView.layer.cornerRadius = 18
        contentView.clipsToBounds = true
        
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(photo)
//        photo.frame = bounds
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
}
