import UIKit
import SnapKit
import Foundation

extension Notification.Name {
    static let userEnteredTargetArea = Notification.Name("userEnteredTargetArea")
    static let userExitedTargetArea = Notification.Name("userExitedTargetArea")
}

class PointsViewController: UIViewController {
    
    private var points: Int
    
    
    init(points: Int) {
        self.points = points
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let pointsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 92/255, green: 40/255, blue: 164/255, alpha: 1.0)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let secretExperiencesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Secret Experience"
        label.textColor = .black
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: 200, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var secretExperiences: [SecretExperience] = [
        SecretExperience(title: "Ananas", imageName: "spark", description: "Try new product", streaks: 5)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updatePointsLabel()
        removeBackButton()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(pointsContainerView)
        pointsContainerView.addSubview(pointsLabel)
        view.addSubview(secretExperiencesLabel)
        view.addSubview(collectionView)
        
        pointsContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        secretExperiencesLabel.snp.makeConstraints { make in
            make.top.equalTo(pointsContainerView.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(secretExperiencesLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        collectionView.register(SecretExperienceCollectionViewCell.self, forCellWithReuseIdentifier: SecretExperienceCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func updatePointsLabel() {
        pointsLabel.text = "🪙 \(points) Points"
    }
    
    private func removeBackButton() {
        navigationItem.hidesBackButton = true
    }
}

extension PointsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return secretExperiences.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecretExperienceCollectionViewCell.identifier, for: indexPath) as? SecretExperienceCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: secretExperiences[indexPath.item])
        return cell
    }
}
