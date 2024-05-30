import UIKit
import SnapKit

class InterestViewController: UIViewController {

    var backgroundImageView: UIImageView!
    var interestButtons: [UIButton]!
    var registerButton: UIButton!
    var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hobbies & Interest"
        setupUi()
        setupConstraints()
        configureNavigationBar()
    }
    
    func setupUi() {
        // Set up the background image
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "Background") // Make sure in your assets
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
        
        let interests = [("Coffee", "cup.and.saucer.fill"),
                         ("Sport", "sportscourt"),
                         ("Entertainment", "popcorn.fill"),
                         ("Shopping", "bag.fill"),
                         ("Gym", "dumbbell.fill")]
        
        interestButtons = interests.map { interest, iconName in
            let button = UIButton(type: .system)
            if let symbolImage = UIImage(systemName: iconName) {
                button.setImage(symbolImage, for: .normal)
                button.tintColor = .darkGray
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            }
            
            button.setTitle(interest, for: .normal)
            button.layer.cornerRadius = 15
            button.layer.borderColor = #colorLiteral(red: 0.8516334891, green: 0.8022179604, blue: 0.9186857343, alpha: 1)
            button.layer.shadowColor = UIColor.lightGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowRadius = 3
            button.layer.shadowOpacity = 0.3
            button.setTitleColor(.darkGray, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9294117093, green: 0.9294117093, blue: 0.9294117093, alpha: 1)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            button.addTarget(self, action: #selector(interestButtonTapped(_:)), for: .touchUpInside)
            return button
        }
        
        interestButtons.forEach { view.addSubview($0) }
        
        registerButton = UIButton(type: .system)
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = #colorLiteral(red: 0.2706783712, green: 0.1171713695, blue: 0.4809373021, alpha: 1)
        registerButton.layer.cornerRadius = 24
        registerButton.layer.shadowColor = UIColor.black.cgColor
        registerButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        registerButton.layer.shadowRadius = 4
        registerButton.layer.shadowOpacity = 0.3
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        view.addSubview(registerButton)
        
        // Set up the logo image view
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
        
        // Show navigation bar with custom settings
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let buttonSpacing: CGFloat = 14.0
        let buttonHeight: CGFloat = 44.0
        let buttonWidth = (UIScreen.main.bounds.width - 60) / 2
        
        interestButtons[0].snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
        }
        
        interestButtons[1].snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
        }
        
        interestButtons[2].snp.makeConstraints { make in
            make.top.equalTo(interestButtons[0].snp.bottom).offset(buttonSpacing)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
        }
        
        interestButtons[3].snp.makeConstraints { make in
            make.top.equalTo(interestButtons[1].snp.bottom).offset(buttonSpacing)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
        }
        
        interestButtons[4].snp.makeConstraints { make in
            make.top.equalTo(interestButtons[2].snp.bottom).offset(buttonSpacing)
            make.centerX.equalToSuperview()
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(interestButtons[4].snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: false)
    }
    
    @objc func interestButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        UIView.animate(withDuration: 0.3,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            if sender.isSelected {
                sender.backgroundColor = #colorLiteral(red: 0.8516334891, green: 0.8022179604, blue: 0.9186857343, alpha: 1)
                sender.setTitleColor(.white, for: .normal)
                sender.tintColor = #colorLiteral(red: 0.8516334891, green: 0.8022179604, blue: 0.9186857343, alpha: 1)
            } else {
                sender.backgroundColor = #colorLiteral(red: 0.9294117093, green: 0.9294117093, blue: 0.9294117093, alpha: 1)
                sender.setTitleColor(.darkGray, for: .normal)
                sender.tintColor = .darkGray
            }
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                sender.transform = CGAffineTransform.identity
            }
        })
    }
    
    @objc func registerButtonTapped() {
        let homeVC = MainTabBarViewController()
        let navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
}
