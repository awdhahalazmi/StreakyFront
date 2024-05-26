import UIKit
import SnapKit

class ProfileViewController: UIViewController {

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
    }

    func setupUI() {
        view.backgroundColor = UIColor.white
        navigationItem.title = "Account Information"

        // Profile Label
        profileLabel = UILabel()
        profileLabel.text = "PROFILE"
        profileLabel.font = UIFont.systemFont(ofSize: 14)
        profileLabel.textColor = .gray
        view.addSubview(profileLabel)

        // Profile Image
        profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "Profile") // Ensure this image is in your assets
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        view.addSubview(profileImageView)

        // Change Profile Picture Button
        changeProfileButton = UIButton(type: .system)
        changeProfileButton.setTitle("Change profile picture", for: .normal)
        changeProfileButton.setTitleColor(.systemPurple, for: .normal)
        changeProfileButton.addTarget(self, action: #selector(changeProfileTapped), for: .touchUpInside)
        view.addSubview(changeProfileButton)

        // Info Container View
        infoContainerView = UIView()
        infoContainerView.backgroundColor = UIColor.white
        infoContainerView.layer.cornerRadius = 5
        infoContainerView.layer.shadowOpacity = 0.3
        infoContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        view.addSubview(infoContainerView)

        // Name Title Label
        nameTitle = UILabel()
        nameTitle.text = "Name"
        nameTitle.font = UIFont.systemFont(ofSize: 14)
        nameTitle.textColor = .gray
        infoContainerView.addSubview(nameTitle)

        // Name Label
        nameLabel = UILabel()
        nameLabel.text = "fatma"
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = .black
        infoContainerView.addSubview(nameLabel)

        // Divider 1
        let divider1 = UIView()
        divider1.backgroundColor =  #colorLiteral(red: 0.9137255549, green: 0.9137254953, blue: 0.9137255549, alpha: 1)
        infoContainerView.addSubview(divider1)

        // Email Title Label
        emailTitle = UILabel()
        emailTitle.text = "Email"
        emailTitle.font = UIFont.systemFont(ofSize: 14)
        emailTitle.textColor = .gray
        infoContainerView.addSubview(emailTitle)

        // Email Label
        emailLabel = UILabel()
        emailLabel.text = "fatma@gmail.com"
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.textColor = .black
        infoContainerView.addSubview(emailLabel)

        // Divider 2
        let divider2 = UIView()
        divider2.backgroundColor =  #colorLiteral(red: 0.9137254357, green: 0.9137255549, blue: 0.9180311561, alpha: 1)
        infoContainerView.addSubview(divider2)

        // Gender Title Label
        genderTitle = UILabel()
        genderTitle.text = "Gender"
        genderTitle.font = UIFont.systemFont(ofSize: 14)
        genderTitle.textColor = .gray
        infoContainerView.addSubview(genderTitle)

        // Gender Label
        genderLabel = UILabel()
        genderLabel.text = "Female"
        genderLabel.font = UIFont.systemFont(ofSize: 16)
        genderLabel.textColor = .black
        infoContainerView.addSubview(genderLabel)

        
    }

    func setupConstraints() {
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(70)
            make.leading.equalToSuperview().offset(20)
        }

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
        }

        changeProfileButton.snp.makeConstraints { make in
            make.centerX.equalTo(profileImageView).offset(150)
            make.centerY.equalTo(profileImageView)

        }

        infoContainerView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(180)
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

        let divider2 = infoContainerView.subviews[5]
        divider2.snp.makeConstraints { make in
            make.top.equalTo(emailTitle.snp.bottom).offset(20)
            make.leading.trailing.equalTo(infoContainerView).inset(20)
            make.height.equalTo(1)
        }

        genderTitle.snp.makeConstraints { make in
            make.top.equalTo(divider2.snp.bottom).offset(20)
            make.leading.equalTo(infoContainerView).offset(20)
        }

        genderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(genderTitle.snp.centerY)
            make.trailing.equalTo(infoContainerView).offset(-20)
        }


    }

    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "power"),
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit", // Set your desired text here
            style: .plain,
            target: self,
            action: #selector(editTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.systemBlue
        navigationItem.leftBarButtonItem?.tintColor = UIColor.systemBlue

    }

    @objc func changeProfileTapped() {
        // Handle change profile picture action
    }

    @objc func logoutTapped() {
        // Display confirmation alert
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            // Handle log out action
            let authVC = AuthViewController()
            self.navigationController?.pushViewController(authVC, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc func editTapped() {
        let editVC = EditProfileViewController()
        navigationController?.pushViewController(editVC, animated: true)
    }
}
