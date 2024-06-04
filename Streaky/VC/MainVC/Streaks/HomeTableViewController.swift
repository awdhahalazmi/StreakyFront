import UIKit
import SnapKit

class HomeTableViewController: UITableViewController,CustomTableViewCellDelegate {
    
    
    func collectionViewCellTapped(at indexPath: IndexPath) {
                
        let vc = StartQuestionViewController()
        vc.questionNumber = indexPath.row
            vc.modalPresentationStyle = .pageSheet

            if let presentationController = vc.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium(), .large()]
                presentationController.prefersGrabberVisible = true
            }

        self.present(vc, animated: true)
    }
    
    
    var rewards: [Reward] = []
    var secretExperiences: [SecretExperience] = []
    var userStreaks: [UserStreak] = []
    var streaks : [Streak] = []
    var token: String?
    var user: UserAccount?


    let sections = ["", "Streaks", "Today's Questions", "Rewards", "Secret Experience"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor =  #colorLiteral(red: 0.6352165341, green: 0.402710855, blue: 0.9805307984, alpha: 1)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        appearance.shadowColor = .clear
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance


        
        // Create notification bell button
        let bellButton = UIButton(type: .custom)
        bellButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        bellButton.tintColor = .white
        bellButton.addTarget(self, action: #selector(handleNotificationButton), for: .touchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: bellButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        tableView.separatorStyle = .none
        tableView.register(StreaksTableViewCell.self, forCellReuseIdentifier: "StreaksTableViewCell")
        tableView.register(PointsTableViewCell.self, forCellReuseIdentifier: PointsTableViewCell.identifier)
        tableView.register(TodayPointTableViewCell.self, forCellReuseIdentifier: TodayPointTableViewCell.identifier)
        tableView.register(RewardsTableViewCell.self, forCellReuseIdentifier: RewardsTableViewCell.identifier)
        tableView.register(SecretTableViewCell.self, forCellReuseIdentifier: SecretTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
   
        if let savedToken = UserDefaults.standard.string(forKey: "AuthToken") {
            print("\(savedToken)")
            fetchUserDetails(token: savedToken)
            fetchRewards(token: savedToken)
            fetchSecretExperiences(token: savedToken)
            fetchUserStreaks(token: savedToken)
            fetchStreaks(token: savedToken)
        } else {
            presentAlertWithTitle(title: "Error", message: "User token is missing")
            
       }
        

    }
    
        
    
    private func fetchRewards(token: String) {
        NetworkManager.shared.getAllRewards(token: token) { [weak self] (result: Result<[Reward], Error>) in
            switch result {
            case .success(let rewards):
                print(rewards)
                self?.rewards = rewards
                self?.tableView.reloadData()
            case .failure(let error):
                // Handle error
                print("dshafjkghl \(error)")
            }
        }
    }
    
    
    private func fetchUserStreaks(token: String) {
        NetworkManager.shared.getUserStreaks(token: token) { [weak self] (result: Result<UserStreak, Error>) in
            switch result {
            case .success(let userStreak):
                self?.userStreaks = [userStreak] // Ensure streaks is an array of UserStreak for compatibility with UITableView
                self?.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch User Streaks: \(error)")
                self?.presentAlertWithTitle(title: "Error", message: "Failed to fetch User streaks.")
            }
        }
    }
    
    private func fetchStreaks(token: String) {
        NetworkManager.shared.getStreaks(token: token) { [weak self] (result: Result<[Streak], Error>) in
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
        NetworkManager.shared.getAllSecretExperiences(token: token) { [weak self] (result: Result<[SecretExperience], Error>) in
            switch result {
            case .success(let secretExperiences):
                print(secretExperiences)
                self?.secretExperiences = secretExperiences
                self?.tableView.reloadData()
            case .failure(let error):
                // Handle error
                print("what \(error)")

            }
        }
    }
                    
    
    private func fetchUserDetails(token: String) {
            NetworkManager.shared.fetchUserDetails(token: token) { [weak self] result in
                switch result {
                case .success(let userAccount):
                    self?.user = userAccount
                    self?.updateUsernameInNavigationBar()
                case .failure(let error):
                    print("Failed to fetch user details: \(error.localizedDescription)")
                }
            }
        }
    
        private func updateUsernameInNavigationBar() {
            guard let username = user?.name else { return }
            let labelusername = UILabel()
            labelusername.text = "Hello, \(username)"
            labelusername.textColor = .white
            labelusername.font = UIFont.systemFont(ofSize: 23, weight: .semibold) // Set font size and weight
            let leftBarButtonItem = UIBarButtonItem(customView: labelusername)
            navigationItem.leftBarButtonItem = leftBarButtonItem
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
                    let totalStreaks = userStreaks.first?.totalStreaks ?? 0
                    cell.configure(streaks: totalStreaks)
            //cell.configure(with: streaks)
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayPointTableViewCell.identifier, for: indexPath) as! TodayPointTableViewCell
            cell.configure(with: streaks)
            cell.delegate = self
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardsTableViewCell.identifier, for: indexPath) as! RewardsTableViewCell
            // Configure the cell
                cell.configure(with: rewards)
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SecretTableViewCell.identifier, for: indexPath) as! SecretTableViewCell
            // Configure the cell
            cell.configure(with: secretExperiences)
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
    
    
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension HomeTableViewController: refreshDelagate {
    func refreshPage() {
        let token = UserDefaults.standard.string(forKey: "AuthToken")

    }
}
