import UIKit

class HomeTableViewController: UITableViewController, CustomTableViewCellDelegate, TableViewCellDelegate {
    
    var rewards: [Reward] = []
    var secretExperiences: [SecretExperience] = []
    var userStreaks: [UserStreak] = []
    var streaks: [Streak] = []
    var token: String?
    var user: UserAccount?
    var helloLabel = UILabel() // Ensure this is a class property
    
    let sections = ["", "Streaks", "Today's Questions", "Rewards", "Secret Experience"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        
        
        if let savedToken = UserDefaults.standard.string(forKey: "AuthToken") {
            fetchUserDetails(token: savedToken)
            fetchRewards(token: savedToken)
            fetchSecretExperiences(token: savedToken)
            fetchUserStreaks(token: savedToken)
            fetchStreaks(token: savedToken)
//            helloLabel.text = user?.name
            self.tableView.reloadData()
        } else {
            presentAlertWithTitle(title: "Error", message: "User token is missing")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let savedToken = UserDefaults.standard.string(forKey: "AuthToken") {
            fetchUserDetails(token: savedToken)
            fetchRewards(token: savedToken)
            fetchSecretExperiences(token: savedToken)
            fetchUserStreaks(token: savedToken)
            fetchStreaks(token: savedToken)
        } else {
            presentAlertWithTitle(title: "Error", message: "User token is missing")
        }
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.6352165341, green: 0.402710855, blue: 0.9805307984, alpha: 1)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        appearance.shadowColor = .clear
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        helloLabel.textColor = .white
        helloLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        let leftBar = UIBarButtonItem(customView: helloLabel)
        navigationItem.leftBarButtonItem = leftBar
        
        let bellButton = UIButton(type: .custom)
        bellButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        bellButton.tintColor = .white
        bellButton.addTarget(self, action: #selector(handleNotificationButton), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: bellButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(StreaksTableViewCell.self, forCellReuseIdentifier: "StreaksTableViewCell")
        tableView.register(PointsTableViewCell.self, forCellReuseIdentifier: PointsTableViewCell.identifier)
        tableView.register(TodayPointTableViewCell.self, forCellReuseIdentifier: TodayPointTableViewCell.identifier)
        tableView.register(RewardsTableViewCell.self, forCellReuseIdentifier: RewardsTableViewCell.identifier)
        tableView.register(SecretTableViewCell.self, forCellReuseIdentifier: SecretTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
    }

    private func fetchUserDetails(token: String) {
           NetworkManager.shared.fetchUserDetails(token: token) { [weak self] result in
               switch result {
               case .success(let user):
                   self?.user = user
                   DispatchQueue.main.async {
                       self?.helloLabel.text = "Hello, \(user.name)"
                   }
                   self?.fetchRewards(token: token)
                   self?.fetchSecretExperiences(token: token)
                   self?.fetchUserStreaks(token: token)
                   self?.fetchStreaks(token: token)
               case .failure(let error):
                   print("Failed to fetch user details: \(error)")
                   self?.presentAlertWithTitle(title: "Error", message: "Failed to fetch user details.")
               }
           }
       }

    private func fetchRewards(token: String) {
        NetworkManager.shared.getAllRewards(token: token) { [weak self] result in
            switch result {
            case .success(let rewards):
                print(rewards)
                self?.rewards = rewards
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch rewards: \(error)")
            }
        }
    }
    
    private func fetchUserStreaks(token: String) {
        NetworkManager.shared.getUserStreaks(token: token) { [weak self] result in
            switch result {
            case .success(let userStreak):
                self?.userStreaks = [userStreak]
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch User Streaks: \(error)")
                self?.presentAlertWithTitle(title: "Error", message: "Failed to fetch User streaks.")
            }
        }
    }
    
    private func fetchStreaks(token: String) {
        NetworkManager.shared.getStreaks(token: token) { [weak self] result in
            switch result {
            case .success(let streak):
                self?.streaks = streak
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch streaks: \(error)")
                self?.presentAlertWithTitle(title: "Error", message: "Failed to fetch streaks.")
            }
        }
    }
    
    private func fetchSecretExperiences(token: String) {
        NetworkManager.shared.getAllSecretExperiences(token: token) { [weak self] result in
            switch result {
            case .success(let secretExperiences):
                print(secretExperiences)
                self?.secretExperiences = secretExperiences
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch Secret Experiences: \(error)")
            }
        }
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
            if let user = user {
                cell.configure(with: Int(Double(user.points)))
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StreaksTableViewCell", for: indexPath) as! StreaksTableViewCell
            let totalStreaks = userStreaks.first?.totalStreaks ?? 0
            cell.configure(streaks: totalStreaks)
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayPointTableViewCell.identifier, for: indexPath) as! TodayPointTableViewCell
            cell.configure(with: streaks)
            cell.delegate = self
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardsTableViewCell.identifier, for: indexPath) as! RewardsTableViewCell
            cell.configure(with: rewards)
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SecretTableViewCell.identifier, for: indexPath) as! SecretTableViewCell
            cell.configure(with: secretExperiences)
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 45
        case 1:
            return 150
        case 2:
            return 160
        case 3:
            return 180
        case 4:
            return 180
        default:
            return UITableView.automaticDimension
        }
    }

    @objc private func handleNotificationButton() {
        print("Notification button tapped")
    }
    
    @objc private func handleProfileTap() {
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: CustomTableViewCellDelegate and TableViewCellDelegate Methods
    
    func collectionViewCellTapped(at indexPath: IndexPath) {
        print("collectionViewCellTapped \(indexPath)")
        
        print("rewards.count \(rewards.count)")
        
        print("streaks[indexPath.row] \(streaks.count)")
        
        guard indexPath.item < rewards.count else {
            print("Index out of range: \(indexPath.item)")
            return
        }
        
        let vc = StartQuestionViewController()
        let selectedStreak = streaks[0]
        
//        guard !selectedStreak.businesses.isEmpty else {
//            print("No businesses available in streak at index: \(indexPath.row)")
//            return
//        }
        
        vc.business = selectedStreak.businesses[indexPath.item]

        
        vc.modalPresentationStyle = .pageSheet

        if let presentationController = vc.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
            presentationController.prefersGrabberVisible = true
        }

        self.present(vc, animated: true)
    }

    func secretCollectionViewCellTapped(at indexPath: IndexPath) {
        let vc = SecretExperienceViewController()
        vc.modalPresentationStyle = .pageSheet
        let secret = secretExperiences[indexPath.row]
        vc.titleLabel.text = secret.title
        vc.descriptionLabel.text = secret.description
        // Assuming vc.image is an imageView
        //vc.image.image = UIImage(named: secret.imageName) // Adjust accordingly

        if let presentationController = vc.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
            presentationController.prefersGrabberVisible = true
        }

        self.present(vc, animated: true)
    }
}

//extension HomeTableViewController: refreshDelagate {
//    func refreshPage() {
//        if let token = UserDefaults.standard.string(forKey: "AuthToken") {
//            fetchUserDetails(token: token)
//            fetchRewards(token: token)
//            fetchSecretExperiences(token: token)
//            fetchUserStreaks(token: token)
//            fetchStreaks(token: token)
//            print(user?.name)
//        } else {
//            presentAlertWithTitle(title: "Error", message: "User token is missing")
//        }
//    }
    

