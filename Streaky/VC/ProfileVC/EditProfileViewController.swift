import UIKit
import SnapKit

class EditProfileViewController: UIViewController {

    var profileImageView: UIImageView!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var genderSegmentedControl: UISegmentedControl!
    var confirmButton: UIButton!
    var infoContainerView: UIView!
    var profileLabel: UILabel!
    var changeProfileButton: UIButton!

    var currentName: String?
    var currentEmail: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureNavigationBar()
        fillCurrentData()
    }

    func setupUI() {
        view.backgroundColor = UIColor.white
        navigationItem.title = "Edit Profile"

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

        // Name TextField
        nameTextField = UITextField()
        nameTextField.font = UIFont.systemFont(ofSize: 16)
        nameTextField.textColor = .black
        nameTextField.placeholder = "name"
        nameTextField.borderStyle = .none
        infoContainerView.addSubview(nameTextField)

        // Divider 1
        let divider1 = UIView()
        divider1.backgroundColor = #colorLiteral(red: 0.9137255549, green: 0.9137254953, blue: 0.9137255549, alpha: 1)
        infoContainerView.addSubview(divider1)

        // Email TextField
        emailTextField = UITextField()
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        emailTextField.textColor = .black
        emailTextField.placeholder = "email"
        emailTextField.borderStyle = .none
        infoContainerView.addSubview(emailTextField)

        // Divider 2
        let divider2 = UIView()
        divider2.backgroundColor = #colorLiteral(red: 0.9137254357, green: 0.9137255549, blue: 0.9180311561, alpha: 1)
        infoContainerView.addSubview(divider2)

        // Gender Segmented Control
        genderSegmentedControl = UISegmentedControl(items: ["Male", "Female"])
        genderSegmentedControl.selectedSegmentIndex = 0
        infoContainerView.addSubview(genderSegmentedControl)

        // Save Button
        confirmButton = UIButton(type: .system)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = #colorLiteral(red: 0.2706783712, green: 0.1171713695, blue: 0.4809373021, alpha: 1)
        confirmButton.layer.cornerRadius = 24
        confirmButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        view.addSubview(confirmButton)

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

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(infoContainerView).offset(20)
            make.leading.trailing.equalTo(infoContainerView).inset(20)
        }

        let divider1 = infoContainerView.subviews[1]
        divider1.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(infoContainerView).inset(20)
            make.height.equalTo(1)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom).offset(10)
            make.leading.trailing.equalTo(infoContainerView).inset(20)
        }

        let divider2 = infoContainerView.subviews[3]
        divider2.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(infoContainerView).inset(20)
            make.height.equalTo(1)
        }

        genderSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(divider2.snp.bottom).offset(10)
            make.leading.trailing.equalTo(infoContainerView).inset(20)
        }

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(infoContainerView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }

    }

    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    func fillCurrentData() {
        nameTextField.text = currentName
        emailTextField.text = currentEmail
    }

    @objc func changeProfileTapped() {
        // Handle change profile picture action
    }

    @objc func saveTapped() {
        // Display confirmation alert
        let alertController = UIAlertController(title: "Confirm Edit", message: "Are you sure you want to save these changes?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            // Save the changes and dismiss or pop the view controller
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    @objc func cancelTapped() {
        // Handle cancel action
        navigationController?.popViewController(animated: true)
    }
}
