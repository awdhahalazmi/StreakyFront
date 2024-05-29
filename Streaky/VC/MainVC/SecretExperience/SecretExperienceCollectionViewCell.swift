import UIKit
import SnapKit

class SecretExperienceCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SecretExperienceCollectionViewCell"
    
    private let experienceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let streaksLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(red: 238/255, green: 100/255, blue: 100/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(experienceImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(streaksLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
        experienceImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.right.equalToSuperview().inset(8)
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(experienceImageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(8)
        }
        
        streaksLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configure(with experience: SecretExperience) {
        experienceImageView.image = UIImage(named: experience.imageName)
        titleLabel.text = experience.title
        descriptionLabel.text = experience.description
        streaksLabel.text = "\(experience.streaks) Streaks"
    }
}
