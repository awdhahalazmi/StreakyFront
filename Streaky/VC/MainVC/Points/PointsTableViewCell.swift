import UIKit
import SnapKit

class PointsTableViewCell: UITableViewCell {
    
    static let identifier = "PointsTableViewCell"
    var user: UserAccount?

    // UI Components
    private let pointsContainerView = UIView()
    private let coinImageView = UIImageView()
    private let pointsLabel = UILabel()
    
    // Constants
    private let coinImageSize: CGFloat = 24
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configure cell corner radius
        contentView.layer.cornerRadius = 0
        contentView.layer.masksToBounds = true
        
        // Configure points container view
        pointsContainerView.backgroundColor = #colorLiteral(red: 0.6352165341, green: 0.402710855, blue: 0.9805307984, alpha: 1)
        contentView.addSubview(pointsContainerView)
        
        // Configure coin image view
        coinImageView.image = UIImage(named: "Coins") 
        coinImageView.tintColor = .white
        coinImageView.contentMode = .scaleAspectFit
        pointsContainerView.addSubview(coinImageView)
        
        // Configure points label
        pointsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        pointsLabel.textColor = .white
        pointsLabel.text = "\(user?.points ?? 0) Points"
        
        pointsContainerView.addSubview(pointsLabel)
        
        if let points = user?.points {
            pointsLabel.text = "\(points) Points"
        }
    }
    
    private func setupConstraints() {
        pointsContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
        
        coinImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(coinImageSize)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        self.selectionStyle = .none
    }
    
    func configure(with points: Int) {
        
    pointsLabel.text = "\(points) Points"
        
    }
}
