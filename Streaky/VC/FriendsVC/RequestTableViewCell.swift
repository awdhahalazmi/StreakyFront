import UIKit
import SnapKit
import Kingfisher

class RequestTableViewCell: UITableViewCell {
    static let identifier = "RequestTableViewCell"

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 123/255, green: 25/255, blue: 251/255, alpha: 1)
        return label
    }()
    
    private let streakLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)  
        label.textColor = UIColor(red: 199/255, green: 173/255, blue: 235/255, alpha: 1)
        return label
    }()
    
   
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 252/255, green: 110/255, blue: 81/255, alpha: 1)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
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
       
        contentView.addSubview(deleteButton)
        contentView.addSubview(confirmButton)

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

        deleteButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(28)
        }
        confirmButton.snp.makeConstraints { make in
            make.right.equalTo(deleteButton.snp.left).offset(-8)
            
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(28)
        }

       
    }

    func configure(with friend: Friend) {
        if let url = URL(string: friend.profileImageUrl) {
            profileImageView.kf.setImage(with: url)
        }
        nameLabel.text = friend.name
        streakLabel.text = "\(friend.streakCount) Streaks"
    }
}
