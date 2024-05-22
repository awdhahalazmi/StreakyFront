import UIKit
import SnapKit
import Kingfisher

class FriendTableViewCell: UITableViewCell {

    static let identifier = "FriendTableViewCell"

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 123/255, green: 25/255, blue: 251/255, alpha: 1)
        return label
    }()

    private let streakLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 199/255, green: 173/255, blue: 235/255, alpha: 1)
        return label
    }()

    private let streakCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .orange
        label.layer.borderColor = UIColor.orange.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "0 Streaks"
        return label
    }()

    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(containerView)
        containerView.addSubview(labelsStackView)
        contentView.addSubview(streakCountLabel)

        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(streakLabel)

        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }

        containerView.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.centerY.equalToSuperview()
            make.right.equalTo(streakCountLabel.snp.left).offset(-16)
        }

        labelsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        streakCountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(70)
        }
    }
    
    

    func configure(with friend: Friend) {
        if let url = URL(string: friend.profileImageUrl) {
            profileImageView.kf.setImage(with: url)
        }
        nameLabel.text = friend.name
        streakLabel.text = "Last Streak at \(friend.lastStreakLocation)"
        streakCountLabel.text = "\(friend.streakCount) Streaks"
    }
}
