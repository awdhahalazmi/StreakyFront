import UIKit
import SnapKit
import Hero
class LoginViewController: UIViewController {
    
    var user: UserLogin?
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var backgroundImageView: UIImageView!
    var welcomeLabel: UILabel!
    var signUpLabel: UILabel!
    var loginButton: UIButton!
    var registerButton: UIButton!
    var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        setupUi()
        configureNavigationBar()
        setupConstraints()
    }
    
    func setupUi() {
        // Set up the background image
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "Background") // Make sure this image is in your assets
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
        
        welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to"
        welcomeLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        welcomeLabel.textColor = .white
        welcomeLabel.textAlignment = .center
        welcomeLabel.layer.shadowColor = UIColor.black.cgColor
        welcomeLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        welcomeLabel.layer.shadowRadius = 4
        welcomeLabel.layer.shadowOpacity = 0.7
        view.addSubview(welcomeLabel)
        
        signUpLabel = UILabel()
        signUpLabel.text = "Streaky"
        signUpLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        signUpLabel.textColor = .white
        signUpLabel.textAlignment = .center
        signUpLabel.layer.shadowColor = UIColor.black.cgColor
        signUpLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        signUpLabel.layer.shadowRadius = 4
        signUpLabel.layer.shadowOpacity = 0.7
        view.addSubview(signUpLabel)
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.cornerRadius = 30
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.2706783712, green: 0.1171713695, blue: 0.4809373021, alpha: 1)
        loginButton.layer.cornerRadius = 24
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        registerButton = UIButton(type: .system)
        registerButton.setTitle("No account? Register now", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .clear
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        view.addSubview(registerButton)
        
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.centerX.equalToSuperview()
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
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
        let onboardingVC = AuthViewController()
        self.navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
    @objc func loginButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            presentAlertWithTitle(title: "Error", message: "Email is required")
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            presentAlertWithTitle(title: "Error", message: "Password is required")
            return
        }

        print("Email: \(email), Password: \(password)") // Debug print

        let user = UserLogin(email: email, password: password)

        NetworkManager.shared.login(user: user) { result in
            
             print(result)
            switch result {
            case .success(let tokenResponse):
                print("Login successful: \(tokenResponse.token)")
                let homeVC = MainTabBarViewController()
                homeVC.token = tokenResponse.token
                print(tokenResponse)
                let navigationController = UINavigationController(rootViewController: homeVC)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)

            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
                self.presentAlertWithTitle(title: "Error", message: "Invalid username or password")
            }
        }
    }

    
    @objc func registerButtonTapped() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }
    
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
