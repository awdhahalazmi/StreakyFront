import UIKit
import SnapKit

class HomeTableViewController: UITableViewController {
    
    let sections = ["", "Streaks", "Today's Questions", "Rewards", "Secret Experience"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize navigation bar
        setupNavigationBar()
        
        tableView.separatorStyle = .none
        tableView.register(StreaksTableViewCell.self, forCellReuseIdentifier: "StreaksTableViewCell")
        tableView.register(PointsTableViewCell.self, forCellReuseIdentifier: PointsTableViewCell.identifier)
        tableView.register(TodayPointTableViewCell.self, forCellReuseIdentifier: TodayPointTableViewCell.identifier)
        tableView.register(RewardsTableViewCell.self, forCellReuseIdentifier: RewardsTableViewCell.identifier)
        tableView.register(SecretTableViewCell.self, forCellReuseIdentifier: SecretTableViewCell.identifier)
    }
    
    private func setupNavigationBar() {
        // Create profile image view
        let profileImageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 18 // Half of the image size
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .clear
        profileImageView.tintColor = .white
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(36) // Adjust size as needed
        }
        
        // Create username label
        let usernameLabel = UILabel()
        usernameLabel.text = "Username"
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        usernameLabel.textColor = .white
        
        // Create a container view for profile image and username
        let profileContainerView = UIStackView(arrangedSubviews: [profileImageView, usernameLabel])
        profileContainerView.axis = .horizontal
        profileContainerView.spacing = 8
        
        // Add tap gesture recognizer to the profile container view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleProfileTap))
        profileContainerView.isUserInteractionEnabled = true
        profileContainerView.addGestureRecognizer(tapGestureRecognizer)
        
        // Create a custom left bar button item with the container view
        let leftBarButtonItem = UIBarButtonItem(customView: profileContainerView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        // Create notification bell button
        let bellButton = UIButton(type: .custom)
        bellButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        bellButton.tintColor = .white
        bellButton.addTarget(self, action: #selector(handleNotificationButton), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: bellButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Customize navigation bar appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.4261863232, green: 0.271607697, blue: 0.652882278, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
       
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc private func handleNotificationButton() {
        // Handle notification button tap
        print("Notification button tapped")
    }
    
    @objc private func handleProfileTap() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PointsTableViewCell.identifier, for: indexPath) as! PointsTableViewCell
            // Configure the cell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StreaksTableViewCell", for: indexPath) as! StreaksTableViewCell
            cell.configure(streaks: 5)
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayPointTableViewCell.identifier, for: indexPath) as! TodayPointTableViewCell
            // Configure the cell
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardsTableViewCell.identifier, for: indexPath) as! RewardsTableViewCell
            // Configure the cell
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SecretTableViewCell.identifier, for: indexPath) as! SecretTableViewCell
            // Configure the cell
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 45
        } else if indexPath.section == 1 {
            return 150
        } else if indexPath.section == 2 {
            return 160
        } else if indexPath.section == 3 {
            return 180
        } else if indexPath.section == 4 {
            return 180
        } else {
            return UITableView.automaticDimension
        }
    }
}
