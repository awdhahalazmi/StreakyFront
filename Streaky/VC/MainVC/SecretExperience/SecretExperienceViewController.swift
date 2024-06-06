import UIKit
import SnapKit

class SecretExperienceViewController: UIViewController {

    var secretExperience: SecretExperience?
    var titleLabel = UILabel()
    var emojiLabel = UILabel()
    var descriptionLabel = UILabel()
    var imageView = UIImageView()
    var titleStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 240/255, green: 230/255, blue: 255/255, alpha: 1)
        
        setupUI()
        setupConstraints()
        
        if let secretExperience = secretExperience {
            titleLabel.text = secretExperience.title
            descriptionLabel.text = secretExperience.description
        }
    }
    
    func setupUI() {
        titleLabel.textColor = UIColor(red: 75/255, green: 0/255, blue: 130/255, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        
        emojiLabel.text = "🤫"
        
        titleStackView.axis = .horizontal
        titleStackView.alignment = .center
        titleStackView.spacing = 8
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(emojiLabel)
        
        view.addSubview(titleStackView)
        
        descriptionLabel.textColor = UIColor(red: 123/255, green: 104/255, blue: 238/255, alpha: 1)
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(140)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
