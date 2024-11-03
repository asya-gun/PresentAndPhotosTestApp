//
//  BannerView.swift
//  PresentAndPhotosTestApp
//
//  Created by Asya Checkanar on 03.11.2024.
//

import UIKit

class BannerView: UIView {
    private var banner: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .bannerBackground)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var collageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(resource: .collage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Try three days free trial"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "You will get all premium templates, additional stickers and no ads"
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

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
        banner.frame = bounds
        setupConstraints()
        banner.frame.origin.y = -banner.frame.size.height
    }
    private func setupView() {
        self.addSubview(banner)
        banner.addSubview(collageImageView)
        stackView = UIStackView(arrangedSubviews: [headerLabel, textLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        banner.addSubview(stackView)
        
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            banner.centerXAnchor.constraint(equalTo: centerXAnchor),
            banner.centerYAnchor.constraint(equalTo: centerYAnchor),
            banner.widthAnchor.constraint(equalToConstant: bounds.width),
            banner.heightAnchor.constraint(equalToConstant: bounds.height),
            
            collageImageView.topAnchor.constraint(equalTo: banner.topAnchor, constant: 14),
            collageImageView.bottomAnchor.constraint(equalTo: banner.bottomAnchor, constant: -10),
            collageImageView.trailingAnchor.constraint(equalTo: banner.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: banner.topAnchor, constant: 22),
            stackView.bottomAnchor.constraint(equalTo: banner.bottomAnchor, constant: -22),
            stackView.leadingAnchor.constraint(equalTo: banner.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: collageImageView.leadingAnchor, constant: -20)
            ])
    }
    func animateBanner() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.banner.frame.origin.y = 0
        })
    }
}
