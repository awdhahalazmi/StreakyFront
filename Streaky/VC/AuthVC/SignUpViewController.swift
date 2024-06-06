import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var backgroundImageView: UIImageView!
    var genderSegmentedControl: UISegmentedControl!
    var welcomeLabel: UILabel!
    var signUpLabel: UILabel!
    var signUpButton: UIButton!
    var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        title = "Sign Up"
        setupUi()
        configureNavigationBar()
        setupConstraints()
    }
    
    func setupUi() {
        // Set up the background image
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "Background") // Make sure in your assets
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
        
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        view.addSubview(nameTextField)
        
        genderSegmentedControl = UISegmentedControl(items: ["Male", "Female"])
        genderSegmentedControl.selectedSegmentIndex = 0
        genderSegmentedControl.backgroundColor = UIColor.white
        view.addSubview(genderSegmentedControl)
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = .white
        emailTextField.borderStyle = .roundedRect
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.cornerRadius = 30
        passwordTextField.borderStyle = .roundedRect
        //passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.2706783712, green: 0.1171713695, blue: 0.4809373021, alpha: 1)
        signUpButton.layer.cornerRadius = 24
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(signUpButton)
        
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
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        genderSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(genderSegmentedControl.snp.bottom).offset(30)
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
        
        // Add back button
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func signUpButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty else {
            presentAlertWithTitle(title: "Error", message: "Name is required")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            presentAlertWithTitle(title: "Error", message: "Email is required")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            presentAlertWithTitle(title: "Error", message: "Password is required")
            return
        }
        
        let genderIndex = genderSegmentedControl.selectedSegmentIndex
        let genderName: String
        if genderIndex == 1 {
            genderName = "Female"
        } else {
            genderName = "Male"
        }
        
        let user = User(name: name, email: email, password: password, genderName: genderName)
        
        NetworkManager.shared.signup(user: user) { [weak self] result in
            print(result)
            switch result {
            case .success(let tokenResponse):
                print("Signup successful: \(tokenResponse.token)")
                print(user)
                let _ = UserDefaults.standard.setValue(tokenResponse.token, forKey: "AuthToken")

                let homeVC = InterestViewController()
                let navigationController = UINavigationController(rootViewController: homeVC)
                navigationController.modalPresentationStyle = .fullScreen
                self?.present(navigationController, animated: true, completion: nil)
            case .failure(let error):
                print("Signup failed: \(error.localizedDescription)")
                self?.presentAlertWithTitle(title: "Error", message: "Sign up failed. Please try again.")
            }
        }
    }
    
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
