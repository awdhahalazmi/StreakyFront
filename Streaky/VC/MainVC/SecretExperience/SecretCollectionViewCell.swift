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
        
    func configure(icon: UIImage, title: String, streaks: String) {
            imageView.image = icon
            secretLabel.text = title
            streakLabel.text = streaks
        }
    
    }

//import SnapKit
//import UIKit
//
//class SecretTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    static let identifier = "SecretTableViewCell"
//    
//    private let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 16
//        layout.minimumInteritemSpacing = 16
//        return UICollectionView(frame: .zero, collectionViewLayout: layout)
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        setupUI()
//        setupConstraints()
//        
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(SecretCollectionViewCell.self, forCellWithReuseIdentifier: "SecretCollectionViewCell")
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.showsHorizontalScrollIndicator = false
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        contentView.addSubview(collectionView)
//    }
//    
//    private func setupConstraints() {
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalTo(contentView)
//            make.height.equalTo(270) // Adjust height as needed
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2 // Number of rewards
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecretCollectionViewCell", for: indexPath) as! SecretCollectionViewCell
//        
//        // Configure your cell with data here
//        let discountText = "\(indexPath.item * 10)% discount voucher]"
//        let pointsText = "\(indexPath.item * 5) Streak"
//        cell.configure(icon: UIImage(named: "ananas")!, discountText: discountText, pointsText: pointsText)
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width / 2 - 24
//        return CGSize(width: width, height: width)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 16
//    }
//
//}
//
//
//
//
//
