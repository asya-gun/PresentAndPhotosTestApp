//
//  PresentButton.swift
//  PresentAndPhotosTestApp
//
//  Created by Asya Checkanar on 01.11.2024.
//

import UIKit

class PresentButton: UIControl {

    private var circle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var presentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(resource: .presentComplete)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "00:30:00"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timer = Timer()
    var seconds = 30*60
    
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
        circle.frame = bounds
        setupConstraints()
    }
    private func setupView() {
        self.addSubview(circle)
        circle.addSubview(presentImageView)
        circle.addSubview(timerLabel)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: centerYAnchor),
            circle.widthAnchor.constraint(equalToConstant: bounds.width),
            circle.heightAnchor.constraint(equalToConstant: bounds.height),
            presentImageView.topAnchor.constraint(equalTo: circle.topAnchor, constant: bounds.height*0.06),
            presentImageView.leadingAnchor.constraint(equalTo: circle.leadingAnchor, constant: bounds.width*0.297),
            presentImageView.trailingAnchor.constraint(equalTo: circle.trailingAnchor, constant: -bounds.width*0.297),
            presentImageView.heightAnchor.constraint(equalTo: circle.heightAnchor, multiplier: 0.59),
            timerLabel.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: circle.leadingAnchor, constant: bounds.width*0.06),
            timerLabel.bottomAnchor.constraint(equalTo: circle.bottomAnchor, constant: -bounds.height*0.173)
            ])
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] timer in
            guard let self else { return }
            if self.seconds == 0 {
                timer.invalidate()
            }
            self.animateKeyframe()
        }
    }
    @objc func countDown() {
        seconds -= 1
        let minutes = seconds / 60
        let secs = seconds % 60
        if seconds == 0 {
            timer.invalidate()
        }
        if minutes < 10 {
            if secs < 10 {
                timerLabel.text = "00:0\(minutes):0\(secs)"
            } else {
                timerLabel.text = "00:0\(minutes):\(secs)"
            }
        } else if secs < 10 {
            timerLabel.text = "00:\(minutes):0\(secs)"
        } else {
            timerLabel.text = "00:\(minutes):\(secs)"
        }
    }
    func animateKeyframe() {
        UIView.animateKeyframes(withDuration: 0.8, delay: 2, options: [.allowUserInteraction, .autoreverse], animations: {
            var progress = 0.0
            for _ in 0..<3 {
                progress += 0.1
                UIView.addKeyframe(withRelativeStartTime: progress, relativeDuration: 0.1) {
                    self.presentImageView.transform = CGAffineTransform(rotationAngle: .pi/10)
                }
                progress += 0.1
                UIView.addKeyframe(withRelativeStartTime: progress, relativeDuration: 0.1) {
                    self.presentImageView.transform = CGAffineTransform(rotationAngle: .pi/(-10))
                }
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.1) {
                self.presentImageView.transform = CGAffineTransform(rotationAngle: .zero)
            }
        })
    }
}
