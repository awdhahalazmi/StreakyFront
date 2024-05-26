import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Onboarding 2")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let whiteContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
            label.text = "Welcome to Streaky\nRewards!"
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
    }()
   
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "We’ll recommend you the best way for spending your points!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let dotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private func createDotView(isSelected: Bool) -> UIView {
        let dotView = UIView()
        dotView.backgroundColor = isSelected ? .darkGray : .lightGray
        dotView.layer.cornerRadius = 4
        dotView.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        return dotView
    }
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 69/255, green: 30/255, blue: 123/255, alpha: 1)
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        view.addSubview(backgroundImageView)
        view.addSubview(whiteContainerView)
        whiteContainerView.addSubview(titleLabel)
        whiteContainerView.addSubview(subtitleLabel)
        whiteContainerView.addSubview(dotStackView)
        whiteContainerView.addSubview(nextButton)
        
        dotStackView.addArrangedSubview(createDotView(isSelected: true))
        dotStackView.addArrangedSubview(createDotView(isSelected: false))
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        whiteContainerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(whiteContainerView).offset(60)
            make.left.right.equalTo(whiteContainerView).inset(20)
        }
        
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(whiteContainerView).inset(20)
        }
        
        dotStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(dotStackView.snp.bottom).offset(20)
            make.left.right.equalTo(whiteContainerView).inset(40)
            make.height.equalTo(44)
            make.bottom.equalTo(whiteContainerView).offset(-40)
        }
    }
    
    @objc private func nextButtonTapped() {
        let nextVC = Onboarding2ViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
