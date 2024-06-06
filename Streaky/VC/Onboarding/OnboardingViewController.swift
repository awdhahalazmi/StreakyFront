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
    
    private let contentContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Streaky\nRewards!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(red: 69/255, green: 30/255, blue: 123/255, alpha: 1)
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
    
    private func createDotView(isSelected: Bool, tag: Int) -> UIView {
        let dotView = UIView()
        dotView.backgroundColor = isSelected ? .darkGray : .lightGray
        dotView.layer.cornerRadius = 4
        dotView.tag = tag
        dotView.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dotTapped(_:)))
        dotView.addGestureRecognizer(tapGesture)
        
        return dotView
    }
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 69/255, green: 30/255, blue: 123/255, alpha: 1)
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var currentStep = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(whiteContainerView)
        whiteContainerView.addSubview(contentContainerView)
        whiteContainerView.addSubview(nextButton)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        whiteContainerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.4)
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(whiteContainerView).inset(20)
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalTo(whiteContainerView).inset(40)
            make.height.equalTo(44)
            make.bottom.equalTo(whiteContainerView).offset(-40)
        }
        
        updateContent()
    }
    
    private func updateContent() {
        for view in contentContainerView.subviews {
            view.removeFromSuperview()
        }
        
        dotStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        switch currentStep {
        case 0:
            setupFirstStep()
        case 1:
            setupSecondStep()
        default:
            break
        }
    }
    
    private func setupFirstStep() {
        contentContainerView.addSubview(titleLabel)
        contentContainerView.addSubview(subtitleLabel)
        contentContainerView.addSubview(dotStackView)
        
        dotStackView.addArrangedSubview(createDotView(isSelected: true, tag: 0))
        dotStackView.addArrangedSubview(createDotView(isSelected: false, tag: 1))
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentContainerView).offset(20)
            make.left.right.equalTo(contentContainerView)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(contentContainerView)
        }
        
        dotStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupSecondStep() {
        let logoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "logo")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        let titleLabel2: UILabel = {
            let label = UILabel()
            label.text = "Easy rewards all over the Place!"
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            label.textColor = UIColor(red: 69/255, green: 30/255, blue: 123/255, alpha: 1)
            label.textAlignment = .center
            return label
        }()
        
        let subtitleLabel2: UILabel = {
            let label = UILabel()
            label.text = "Daily streaks with all rewards at the tip of your fingers!"
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textColor = .darkGray
            label.textAlignment = .center
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            return label
        }()
        
        dotStackView.addArrangedSubview(createDotView(isSelected: false, tag: 0))
        dotStackView.addArrangedSubview(createDotView(isSelected: true, tag: 1))
        
        contentContainerView.addSubview(logoImageView)
        contentContainerView.addSubview(titleLabel2)
        contentContainerView.addSubview(subtitleLabel2)
        contentContainerView.addSubview(dotStackView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(contentContainerView).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(80)
        }
        
        titleLabel2.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(-70)
            make.left.right.equalTo(contentContainerView)
        }
        
        subtitleLabel2.snp.makeConstraints { make in
            make.top.equalTo(titleLabel2.snp.bottom).offset(30)
            make.left.right.equalTo(contentContainerView)
        }
        
        dotStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel2.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func nextButtonTapped() {
        currentStep += 1
        
        if currentStep > 1 {
            let nextVC = AuthViewController() // Replace with your next view controller
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            // Update content with animation
            UIView.transition(with: contentContainerView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.updateContent()
            }, completion: nil)
            
            // Update background image with animation
            UIView.transition(with: backgroundImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.updateBackgroundImage()
            }, completion: nil)
        }
    }
    
    @objc private func dotTapped(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag, tag == 0 {
            currentStep = 0
            UIView.transition(with: contentContainerView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.updateContent()
            }, completion: nil)
            UIView.transition(with: backgroundImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.updateBackgroundImage()
            }, completion: nil)
        }
    }
    
    private func updateBackgroundImage() {
        switch currentStep {
        case 0:
            backgroundImageView.image = UIImage(named: "Onboarding 2")
        case 1:
            backgroundImageView.image = UIImage(named: "Onboarding")
        default:
            break
        }
    }
}


