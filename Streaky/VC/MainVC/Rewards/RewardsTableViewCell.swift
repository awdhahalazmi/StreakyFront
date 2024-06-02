import UIKit
import SnapKit

import UIKit
import SnapKit

class RewardsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "RewardsTableViewCell"
    
    private var rewards: [Reward] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.8982707858, blue: 0.7560862899, alpha: 0.2549316406)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RewardsCollectionViewCell.self, forCellWithReuseIdentifier: "RewardsCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(270) // Adjust height as needed
        }
    }
    
    func configure(with rewards: [Reward]) {
        self.rewards = rewards
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rewards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardsCollectionViewCell", for: indexPath) as! RewardsCollectionViewCell
            
            let reward = rewards[indexPath.item]
            let discountText = reward.description
            let pointsText = "\(reward.pointsClaimed) Points"
            // Assuming you have an image loading function or use a placeholder if image loading fails
            let icon = UIImage(named: reward.business.image) ?? UIImage()
            
            cell.configure(icon: icon, discountText: discountText, pointsText: pointsText)
            
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 24
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

//import UIKit
//import SnapKit
//
//class RewardsCollectionViewCell: UICollectionViewCell {
//
//    // UI Elements
//    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 16
//        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left and right corners only
//        imageView.image = UIImage(named: "ananas") // Replace with your icon image
//        return imageView
//    }()
//    
//    private let discountLabel: UILabel = {
//        let label = UILabel()
//        label.text = "10% discount voucher"
//        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        label.textColor = .black
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let pointsLabel: UILabel = {
//        let label = UILabel()
//        label.text = "1.000 Points"
//        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        label.textColor = .orange
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let containerView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 16
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.white.cgColor
//        view.layer.shadowRadius = 1
//        view.layer.shadowOpacity = 0.2
//        view.layer.shadowColor = UIColor.lightGray.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 4)
//
//        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        return view
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        contentView.addSubview(containerView)
//        containerView.addSubview(imageView)
//        containerView.addSubview(discountLabel)
//        containerView.addSubview(pointsLabel)
//        
//    }
//    
//    private func setupConstraints() {
//        containerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(4)
//        }
//        
//        imageView.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.height.equalTo(containerView.snp.height).multipliedBy(0.6)
//        }
//        
//        discountLabel.snp.makeConstraints { make in
//            make.top.equalTo(imageView.snp.bottom).offset(10)
//            make.leading.trailing.equalToSuperview().inset(16)
//        }
//        
//        pointsLabel.snp.makeConstraints { make in
//            make.top.equalTo(discountLabel.snp.bottom).offset(10)
//            make.leading.trailing.equalToSuperview().inset(16)
//            make.bottom.equalToSuperview().offset(-10)
//        }
//    }
//    
//    func configure(icon: UIImage, discountText: String, pointsText: String) {
//        imageView.image = icon
//        discountLabel.text = discountText
//        pointsLabel.text = pointsText
//    }
//}
//
//
