//
//  SecretCollectionViewCell.swift
//  Streaky
//
//  Created by Fatma Buyabes on 29/05/2024.
//

import UIKit
import SnapKit

class SecretCollectionViewCell: UICollectionViewCell {

        // UI Elements
        private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 16
            imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left and right corners only
            imageView.image = UIImage(named: "ananas") // Replace with your icon image
            return imageView
        }()
        
        private let secretLabel: UILabel = {
            let label = UILabel()
            label.text = "10% discount voucher"
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
        
        private let streakLabel: UILabel = {
            let label = UILabel()
            label.text = "5 Streak"
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            label.textColor = .orange
            label.textAlignment = .center
            return label
        }()
        
        private let containerView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 16
            view.layer.borderWidth = 0.5
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.shadowRadius = 1
            view.layer.shadowOpacity = 0.2
            view.layer.shadowColor = UIColor.lightGray.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 4)
            view.backgroundColor = .white
            return view
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            contentView.addSubview(containerView)
            containerView.addSubview(imageView)
            containerView.addSubview(secretLabel)
            containerView.addSubview(streakLabel)
        }
        
        private func setupConstraints() {
            containerView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(4)
            }
            
            imageView.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(containerView.snp.height).multipliedBy(0.6)
            }
            
            secretLabel.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(16)
            }
            
            streakLabel.snp.makeConstraints { make in
                make.top.equalTo(secretLabel.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().offset(-10)
            }
        }
        
        func configure(icon: UIImage, titleText: String, descriptionText: String, streakClaimedText: String) {
            imageView.image = icon
            secretLabel.text = titleText
            streakLabel.text = descriptionText
            streakLabel.text = streakClaimedText
        }
        
    private func loadImage(from urlString: String) {
            guard let url = URL(string: urlString) else {
                print("Invalid URL: \(urlString)")
                imageView.image = UIImage(named: "placeholder")
                return
            }

            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    print("Error loading image from URL: \(error)")
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(named: "placeholder")
                    }
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("Failed to load image data")
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(named: "placeholder")
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }.resume()
        }
    
    
    }

