//
//  ViewController.swift
//  PresentAndPhotosTestApp
//
//  Created by Asya Checkanar on 31.10.2024.
//

import UIKit

class ViewController: UIViewController {

    private let bannerView: BannerView = {
        let view = BannerView(frame: CGRect(x: 0, y: 0, width: 343, height: 108))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private let tagsScrollView: TagsScrollView = {
        let scrollView = TagsScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let presentButton: PresentButton = {
        let size: Int = 100
        let button = PresentButton(frame: CGRect(x: 0, y: 0, width: size, height: size))
        button.layer.cornerRadius = CGFloat(size/2)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let collectionView: UICollectionView = {
        let layout = CustomLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.contentInset.left = 16
        collectionView.contentInset.right = 16
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    private let imageArray: [UIImage] = [UIImage(resource: .fall1), UIImage(resource: .fall2), UIImage(resource: .fall3), UIImage(resource: .fall4), UIImage(resource: .fall5), UIImage(resource: .fall6), UIImage(resource: .fall7), UIImage(resource: .fall8)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presentButton.startTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.bannerView.animateBanner()
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setConstraints()
    }
    func setupView() {
        view.backgroundColor = .black
        view.addSubview(bannerView)
        view.addSubview(tagsScrollView)
        view.addSubview(collectionView)
        view.addSubview(presentButton)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        if let layout = collectionView.collectionViewLayout as? CustomLayout {
          layout.delegate = self
        }
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bannerView.heightAnchor.constraint(equalToConstant: 108),
            tagsScrollView.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 16),
            tagsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tagsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tagsScrollView.heightAnchor.constraint(equalToConstant: 60),
            collectionView.topAnchor.constraint(equalTo: tagsScrollView.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            presentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            presentButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            presentButton.widthAnchor.constraint(equalToConstant: 100),
            presentButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let insets = collectionView.contentInset
        let width = (collectionView.bounds.width - (insets.left + insets.right))/2
        let img = self.imageArray[indexPath.row]
        let multiplier = img.size.height/img.size.width
        
        return width*multiplier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            print("cell failure")
            fatalError("Failed to dequeue cell")
        }
        let photo = self.imageArray[indexPath.row]
        cell.configure(image: photo)
        return cell
    }
}
