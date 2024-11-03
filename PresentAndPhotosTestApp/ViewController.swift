//
//  ViewController.swift
//  PresentAndPhotosTestApp
//
//  Created by Asya Checkanar on 31.10.2024.
//

import UIKit

class ViewController: UIViewController {

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Present UI Element"
        return label
    }()
    
    private let bannerView: BannerView = {
        let view = BannerView(frame: CGRect(x: 0, y: 0, width: 343, height: 108))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private let presentButton: PresentButton = {
        let button = PresentButton(frame: CGRect(x: 0, y: 0, width: 168, height: 168))
        button.layer.cornerRadius = 168/2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(bannerView)
        view.addSubview(presentButton)
        view.addSubview(headerLabel)
        presentButton.startTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.bannerView.animateBanner()
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setConstraints()
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bannerView.heightAnchor.constraint(equalToConstant: 108),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            presentButton.widthAnchor.constraint(equalToConstant: 168),
            presentButton.heightAnchor.constraint(equalToConstant: 168),
        ])
    }
}

