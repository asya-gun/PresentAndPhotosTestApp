//
//  TagsScrollView.swift
//  PresentAndPhotosTestApp
//
//  Created by Asya Checkanar on 03.11.2024.
//

import UIKit

class TagsScrollView: UIView {

    private var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "Подходит для:"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    var tags: [String] = ["#Осень", "#Портрет", "#insta-стиль", "#Люди", "#Привлекательный"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    private func setupView() {
        self.addSubview(headerLabel)
        self.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 4),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: bounds.width),
            collectionView.heightAnchor.constraint(equalToConstant: 35),
            ])
    }
}
extension TagsScrollView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
            print("cell failure")
            fatalError("Failed to dequeue cell")}
        let tag = self.tags[indexPath.row]
        cell.configure(text: tag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = tags[indexPath.row]
        label.sizeToFit()
        let size = label.frame.width + 10
//        let size = tags[indexPath.row].count*8 + 20
        return CGSize(width: size, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 16, bottom: 0, right: 0)
    }
}
