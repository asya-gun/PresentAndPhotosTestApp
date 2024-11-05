//
//  TagCollectionViewCell.swift
//  PresentAndPhotosTestApp
//
//  Created by Asya Checkanar on 04.11.2024.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    static let identifier = "TagCollectionViewCell"
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .tag)
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "#Осень"
        label.textAlignment = .left
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public func configure(text: String) {
        label.text = text
        setupUI()
        setConstraints()
    }
    private func setupUI() {
        contentView.layer.cornerRadius = 13
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor(resource: .tag).withAlphaComponent(0.3)
        contentView.addSubview(label)
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
        ])
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
    }
}
