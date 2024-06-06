import UIKit
import CoreLocation

class HomeTableViewController: UITableViewController, CustomTableViewCellDelegate, TableViewCellDelegate, CLLocationManagerDelegate {
    
    var rewards: [Reward] = []
    var secretExperiences: [SecretExperience] = []
    var userStreaks: [UserStreak] = []
    var streaks: [Streak] = []
    var token: String?
    var user: UserAccount?
    var helloLabel = UILabel()

    var userLocation: CLLocation?
    let locationManager = CLLocationManager()

    
    let sections = ["", "Streaks", "Today's Questions", "Rewards", "Secret Experience"]

    // Target location coordinates
    // TODO get the list of locations from the backend and then loop to check if the user location is inside any of the branches
//    let targetLatitude: CLLocationDegrees = location?.latitude
//    let targetLongitude: CLLocationDegrees = 47.9071659
//    let targetRadius: CLLocationDistance = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        getCurrentLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        helloLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        helloLabel.text = "Hello,"
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
    
    func getCurrentLocation() {
        locationManager.delegate = self
        
        // Request authorization
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        print("Location services are not enabled 1")
        
        // TODO don't call on main thread
        if CLLocationManager.locationServicesEnabled() {
            print("Location services are not enabled 2")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            print("Location services are not enabled 3")
        }
    }


    private func fetchUserDetails(token: String) {
        NetworkManager.shared.fetchUserDetails(token: token) { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.user = user
                    self?.updateNavigationBarWithUserName(user.name)
                    self?.fetchRewards(token: token)
                    self?.fetchSecretExperiences(token: token)
                    self?.fetchUserStreaks(token: token)
                    self?.fetchStreaks(token: token)
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Failed to fetch user details: \(error)")
                    self?.presentAlertWithTitle(title: "Error", message: "Failed to fetch user details.")
                }
            }
        }
    }

    private func updateNavigationBarWithUserName(_ userName: String) {
        helloLabel.text = "Hello, \(userName)"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: helloLabel)
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
    
    func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: CustomTableViewCellDelegate and TableViewCellDelegate Methods
    
    func collectionViewCellTapped(at indexPath: IndexPath) {
        
        
        //Location Code
        //LOGS:
        /// User location: 29.3581396, 47.9070288
        /// User location updated: 29.3581396, 47.9070288
        ///Distance to target: 28.07471041270769 meters
        ///You are in the target area.

        let storeLocation = streaks[0].businesses[indexPath.item].locations[2]
            
            if let userLocation = userLocation {
                checkProximity(to: userLocation, storeLocation: storeLocation)
            } else {
                print("User location is not available yet")
            }
        
        
        
        //YOUR CODE
        print("collectionViewCellTapped \(indexPath)")
        
        print("rewards.count \(rewards.count)")
        
        print("streaks[indexPath.row] \(streaks.count)")
        
        guard indexPath.item < rewards.count else {
            print("Index out of range: \(indexPath.item)")
            return
        }
        
        let vc = StartQuestionViewController()
        let selectedStreak = streaks[0]
        
        // Pass the location to the next view controller
//        if let location = userLocation {
            print("userLocation: \(userLocation)")
            vc.userLocation = userLocation
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


extension HomeTableViewController {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled() {
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                print("Location services are not enabled")
            }
        case .notDetermined, .restricted, .denied:
            // Handle the case where the user has not granted location access
            print("Location access denied or restricted")
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let userLocation = locations.last else {
               print("No user location available")
               return
           }

           self.userLocation = userLocation
           
           print("User location: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
       }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Failed to get user location: \(error.localizedDescription)")
       }
       
       func checkProximity(to userLocation: CLLocation, storeLocation: Location) {
           let storeCLLocation = CLLocation(latitude: storeLocation.latitude, longitude: storeLocation.longitude)
           let distance = userLocation.distance(from: storeCLLocation)
           
           if distance <= storeLocation.radius {
               print("User is at the place: \(storeLocation.name)")
           } else {
               print("User is not at the place")
           }
           
           print("Distance to target: \(distance) meters")
       }
   
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let a = locations.last else {
//            print("No user location available")
//            return
//        }
//        
//        if let location = locations.last {
//            print("User location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
//            print("User location updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
//            checkProximity(to: location)
//            userLocation = location
//        }
//        
//    }
    
//    func checkProximity(to userLocation: CLLocation) {
//        let targetLocation = CLLocation(latitude: targetLatitude, longitude: targetLongitude)
//        let distance = userLocation.distance(from: targetLocation)
//        
//        print("Distance to target: \(distance) meters")
//        
//        if distance <= targetRadius {
//            // TODO + Streak :) :) :) 
//            print("You are in the target area.")
//        } else {
//            print("You are not in the target area.")
//        }
//    }
}
