//  LoginViewController.swift
//  Streaky
//
//  Created by Fatma Buyabes on 21/05/2024.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {

    var background = UIImageView()
    var logoImageView = UIImageView()
    var welcomeLabel = UILabel()
    var descriptionLabel = UILabel()
    var loginButton = UIButton()
    var signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        setupUi()
        setupConstraints()
        
    }
    
    func setupUi() {
        
        background.image = UIImage(named: "Background")
        background.contentMode = .scaleAspectFill
        background.clipsToBounds = true
        view.addSubview(background)
        
        
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
        
       
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        welcomeLabel.textColor = .white
        welcomeLabel.textAlignment = .left
        view.addSubview(welcomeLabel)
        
        
        descriptionLabel.text = "Unlock exclusive benefits and discover a world of perks at your fingertips with Streaky"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        view.addSubview(descriptionLabel)
        
        //loginButton = UIButton(type: .system)
//        loginButton.setTitle("Login to your account", for: .normal)
//        loginButton.backgroundColor = #colorLiteral(red: 0.3071659207, green: 0.1487102509, blue: 0.5210966468, alpha: 1)
//        loginButton.layer.cornerRadius = 24
//        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//        view.addSubview(loginButton)
        
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login to your account", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.2706783712, green: 0.1171713695, blue: 0.4809373021, alpha: 1)
        loginButton.layer.cornerRadius = 24
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
       // signUpButton = UIButton(type: .system)
//        signUpButton.setTitle("Sign up", for: .normal)
//        signUpButton.backgroundColor = .clear
//        signUpButton.setTitleColor(.white, for: .normal)
//        signUpButton.layer.borderWidth = 2
//        signUpButton.layer.borderColor = #colorLiteral(red: 0.3071659207, green: 0.1487102509, blue: 0.5210966468, alpha: 1)
//        signUpButton.layer.cornerRadius = 24
//        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
//        view.addSubview(signUpButton)
        
        signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = .clear
        signUpButton.setTitleColor(.white, for: .normal)
//        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.borderColor = #colorLiteral(red: 0.3071659207, green: 0.1487102509, blue: 0.5210966468, alpha: 1)
       
        signUpButton.layer.cornerRadius = 24
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(signUpButton)
    }
    
    func setupConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(230)
            make.width.height.equalTo(160)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.leading.equalTo(descriptionLabel.snp.leading)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-100)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc func loginButtonTapped() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
        }

    @objc func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }
}
