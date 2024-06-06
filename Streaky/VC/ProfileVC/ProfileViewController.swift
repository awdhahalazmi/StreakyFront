import UIKit
import SnapKit
import Alamofire

class ProfileViewController: UIViewController {
    
    var token: String?
    var userAccount: UserAccount?
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var nameTitle: UILabel!
    var emailTitle: UILabel!
    var genderTitle: UILabel!
    var emailLabel: UILabel!
    var genderLabel: UILabel!
    var changeProfileButton: UIButton!
    var infoContainerView: UIView!
    var profileLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupNavigationBar()
        
        if let savedToken = UserDefaults.standard.string(forKey: "AuthToken") {
            print("token in profile: \(savedToken)")
            fetchUserDetails(token: savedToken)
        } else {
            presentAlertWithTitle(title: "Error", message: "User token is missing")
        }
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.systemGroupedBackground
        navigationItem.title = "Account Information"
        
        profileLabel = UILabel()
        profileLabel.text = "PROFILE"
        profileLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        profileLabel.textColor = .gray
        view.addSubview(profileLabel)
        
        profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "Profile")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        view.addSubview(profileImageView)
        
        infoContainerView = UIView()
        infoContainerView.backgroundColor = UIColor.white
        infoContainerView.layer.cornerRadius = 10
        infoContainerView.layer.shadowOpacity = 0.1
        infoContainerView.layer.shadowColor = UIColor.black.cgColor
        infoContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        infoContainerView.layer.shadowRadius = 4
        view.addSubview(infoContainerView)
        
        nameTitle = UILabel()
        nameTitle.text = "Name"
        nameTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        nameTitle.textColor = .gray
        infoContainerView.addSubview(nameTitle)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameLabel.textColor = .black
        infoContainerView.addSubview(nameLabel)
        
        let divider1 = UIView()
        divider1.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        infoContainerView.addSubview(divider1)
        
        emailTitle = UILabel()
        emailTitle.text = "Email"
        emailTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        emailTitle.textColor = .gray
        infoContainerView.addSubview(emailTitle)
        
        emailLabel = UILabel()
        emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailLabel.textColor = .black
        infoContainerView.addSubview(emailLabel)
        
        let divider2 = UIView()
        divider2.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        infoContainerView.addSubview(divider2)
        
        
    }
    
    func setupConstraints() {
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        infoContainerView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(130)
        }
        
        nameTitle.snp.makeConstraints { make in
            make.top.equalTo(infoContainerView).offset(20)
            make.leading.equalTo(infoContainerView).offset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameTitle.snp.centerY)
            make.trailing.equalTo(infoContainerView).offset(-20)
        }
        
        let divider1 = infoContainerView.subviews[2]
        divider1.snp.makeConstraints { make in
            make.top.equalTo(nameTitle.snp.bottom).offset(20)
            make.leading.trailing.equalTo(infoContainerView).inset(20)
            make.height.equalTo(1)
        }
        
        emailTitle.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom).offset(20)
            make.leading.equalTo(infoContainerView).offset(20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(emailTitle.snp.centerY)
            make.trailing.equalTo(infoContainerView).offset(-20)
        }
        
        
        
        
        
        
    }

    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.6352165341, green: 0.402710855, blue: 0.9805307984, alpha: 1)

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "power"),
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            title: "Edit",
//            style: .plain,
//            target: self,
//            action: #selector(editTapped)
//        )
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
    
        appearance.shadowColor = .clear
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func logoutTapped() {
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            UserDefaults.standard.removeObject(forKey: "AuthToken")
            let authVC = AuthViewController()
            authVC.modalPresentationStyle = .fullScreen
            self.present(authVC, animated: false, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
//    @objc func editTapped() {
//        let editVC = edit()
//        navigationController?.pushViewController(editVC, animated: true)
//    }
    
    func fetchUserDetails(token: String) {
        NetworkManager.shared.fetchUserDetails(token: token) { [weak self] result in
            switch result {
            case .success(let userDetails):
                DispatchQueue.main.async {
                    self?.nameLabel.text = userDetails.name
                    self?.emailLabel.text = userDetails.email
                    //self?.genderLabel.text = userDetails.genderName
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presentAlertWithTitle(title: "Error", message: "Failed to fetch user details: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadProfileImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.profileImageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController: RefreshDelagate {
    func refreshPage() {
        if let token = UserDefaults.standard.string(forKey: "AuthToken") {
            fetchUserDetails(token: token)
        } else {
            presentAlertWithTitle(title: "Error", message: "User token is missing")
        }
    }
}
