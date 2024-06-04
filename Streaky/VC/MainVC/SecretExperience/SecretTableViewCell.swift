import SnapKit
import UIKit

protocol TableViewCellDelegate: AnyObject {
    func secretCollectionViewCellTapped(at indexPath: IndexPath)
}

class SecretTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "SecretTableViewCell"
    
    private var secretExperiences: [SecretExperience] = []
    weak var delegate: TableViewCellDelegate?

    
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SecretCollectionViewCell.self, forCellWithReuseIdentifier: "SecretCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with secretExperiences: [SecretExperience]) {
        self.secretExperiences = secretExperiences
        collectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return secretExperiences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecretCollectionViewCell", for: indexPath) as! SecretCollectionViewCell
        
        let secretExperience = secretExperiences[indexPath.item]
        let titleText = secretExperience.title
        let descriptionText = secretExperience.description
        let streakClaimedText = "\(secretExperience.streakClaimed) Streaks"
        let icon = UIImage(named: secretExperience.businessImage) ?? UIImage()
        
        cell.configure(iconURL: secretExperience.businessImage, titleText: titleText, descriptionText: descriptionText, streakClaimedText: streakClaimedText)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 24
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.secretCollectionViewCellTapped(at: indexPath)
    }

}
