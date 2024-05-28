//import UIKit
//import SnapKit
//
//class Onboarding2ViewController: UIViewController {
//
//    private let backgroundImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "Onboarding")
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//    
//    private let whiteContainerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 30
//        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        view.clipsToBounds = true
//        return view
//    }()
//    
//    private let logoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "logo")
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Easy rewards all over the Place!"
//        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//        label.textColor = UIColor(red: 69/255, green: 30/255, blue: 123/255, alpha: 1)
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let subtitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Daily streaks with all rewards at the tip of your fingers!"
//        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        label.textColor = .darkGray
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        return label
//    }()
//    
//    private let dotStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .equalSpacing
//        stackView.alignment = .center
//        stackView.spacing = 8
//        return stackView
//    }()
//    
//    private func createDotView(isSelected: Bool) -> UIView {
//        let dotView = UIView()
//        dotView.backgroundColor = isSelected ? UIColor(red: 69/255, green: 30/255, blue: 123/255, alpha: 1) : .lightGray
//        dotView.layer.cornerRadius = 4
//        dotView.snp.makeConstraints { make in
//            make.width.height.equalTo(8)
//        }
//        return dotView
//    }
//    
//    private let nextButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Next", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor(red: 69/255, green: 30/255, blue: 123/255, alpha: 1)
//        button.layer.cornerRadius = 22
//        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        setupNavigationBar()
//    }
//    
//    private func setupViews() {
//        view.addSubview(backgroundImageView)
//        view.addSubview(whiteContainerView)
//        whiteContainerView.addSubview(logoImageView)
//        whiteContainerView.addSubview(titleLabel)
//        whiteContainerView.addSubview(subtitleLabel)
//        whiteContainerView.addSubview(dotStackView)
//        whiteContainerView.addSubview(nextButton)
//        
//        // Add dots to the stack view
//        dotStackView.addArrangedSubview(createDotView(isSelected: false))
//        dotStackView.addArrangedSubview(createDotView(isSelected: true))
//        
//        backgroundImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        whiteContainerView.snp.makeConstraints { make in
//            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(view).multipliedBy(0.4)
//        }
//        
//        logoImageView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(200)
//            make.height.equalTo(80)
//        }
//        
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(whiteContainerView).offset(70)
//            make.left.right.equalTo(whiteContainerView).inset(20)
//        }
//        
//        subtitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//            make.left.right.equalTo(whiteContainerView).inset(20)
//        }
//        
//        dotStackView.snp.makeConstraints { make in
//            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
//            make.centerX.equalToSuperview()
//        }
//        
//        nextButton.snp.makeConstraints { make in
//            make.top.equalTo(dotStackView.snp.bottom).offset(20)
//            make.left.right.equalTo(whiteContainerView).inset(40)
//            make.height.equalTo(44)
//            make.bottom.equalTo(whiteContainerView).offset(-40)
//        }
//    }
//    
//    private func setupNavigationBar() {
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        
//        let backImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate)
//        navigationController?.navigationBar.backIndicatorImage = backImage
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
//        navigationController?.navigationBar.tintColor = .white
//    }
//    
//    @objc private func nextButtonTapped() {
//        let AuthVC = AuthViewController()
//        navigationController?.pushViewController(AuthVC, animated: true)
//
//    }
//}
