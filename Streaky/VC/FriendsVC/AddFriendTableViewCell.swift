import UIKit
import SnapKit
import Kingfisher

class AddFriendTableViewCell: UITableViewCell {
    static let identifier = "AddFriendTableViewCell"
    weak var delegate: AddFriendCellDelegate?
    private var friend: Friend?

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 199/255, green: 173/255, blue: 235/255, alpha: 1)
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor(red: 252/255, green: 110/255, blue: 81/255, alpha: 1)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(streakLabel)
        contentView.addSubview(addButton)

        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }

        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.top.equalToSuperview().offset(16)
        }

        streakLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }

        addButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }

    @objc private func addButtonTapped() {
        guard let friend = friend else { return }
        delegate?.didTapAddButton(for: friend)
    }

    func configure(with friend: Friend) {
        self.friend = friend
        if let url = URL(string: friend.profileImageUrl) {
            profileImageView.kf.setImage(with: url)
        }
        nameLabel.text = friend.name
        streakLabel.text = "\(friend.streakCount) Streaks"
    }
}
