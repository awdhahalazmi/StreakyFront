import SnapKit
import UIKit

class SecretTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "SecretTableViewCell"
    
    private var secretExperiences: [SecretExperience] = []
    
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
        let title = secretExperience.title
        let streaks = "\(secretExperience.streakClaimed) Streak"
        let icon = UIImage(named: secretExperience.businessImage) ?? UIImage()
        
        cell.configure(icon: icon, title: title, streaks: streaks)
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
