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
            let icon = UIImage(named: reward.businessImage) ?? UIImage()
            
            cell.configure(icon: reward.businessImage, discountText: discountText, pointsText: pointsText)
            
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



