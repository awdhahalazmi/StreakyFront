import UIKit
import CoreLocation
import SnapKit


// Dummy data for Location
let location1 = Location(id: 1, name: "Location 1", url: "http://example.com/1", radius: 10.0, latitude: 37.7749, longitude: -122.4194)
let location2 = Location(id: 2, name: "Location 2", url: "http://example.com/2", radius: 20.0, latitude: 34.0522, longitude: -118.2437)

// Dummy data for Category
let category1 = Category(id: 1, name: "Category 1")
let category2 = Category(id: 2, name: "Category 2")

// Dummy data for Streaks
let streak1 = Streaks(id: 1, title: "Streak 1", description: "Description 1", businessId: 1, startDate: Date(), endDate: Date())
let streak2 = Streaks(id: 2, title: "Streak 2", description: "Description 2", businessId: 2, startDate: Date(), endDate: Date())

// Dummy data for Reward
let reward1 = Reward(id: 1, streakId: 1, streak: streak1, description: "Reward 1", pointsClaimed: 100, businessId: 1, business: Business(id: 1, name: "Business 1", categoryId: 1, image: "", question: "", correctAnswer: "", wrongAnswer1: "", wrongAnswer2: "", question2: "", correctAnswerQ2: "", wrongAnswerQ2_1: "", wrongAnswerQ2_2: ""))
let reward2 = Reward(id: 2, streakId: 2, streak: streak2, description: "Reward 2", pointsClaimed: 200, businessId: 2, business: Business(id: 2, name: "Business 2", categoryId: 2, image: "", question: "", correctAnswer: "", wrongAnswer1: "", wrongAnswer2: "", question2: "", correctAnswerQ2: "", wrongAnswerQ2_1: "", wrongAnswerQ2_2: ""))

// Dummy data for SecretExperience
let secretExperience1 = SecretExperience(id: 1, startDate: Date(), endDate: Date(), title: "Secret Experience 1", description: "Description 1", streakClaimed: 10, businessId: 1, business: Business(id: 1, name: "Business 1", categoryId: 1, image: "", question: "", correctAnswer: "", wrongAnswer1: "", wrongAnswer2: "", question2: "", correctAnswerQ2: "", wrongAnswerQ2_1: "", wrongAnswerQ2_2: ""))
let secretExperience2 = SecretExperience(id: 2, startDate: Date(), endDate: Date(), title: "Secret Experience 2", description: "Description 2", streakClaimed: 20, businessId: 2, business: Business(id: 2, name: "Business 2", categoryId: 2, image: "", question: "", correctAnswer: "", wrongAnswer1: "", wrongAnswer2: "", question2: "", correctAnswerQ2: "", wrongAnswerQ2_1: "", wrongAnswerQ2_2: ""))

// Dummy data for UserStreak
let userStreak1 = UserStreak(id: 1, userId: 1, streakId: 1, startDate: Date(), endDate: Date(), streak: streak1)
let userStreak2 = UserStreak(id: 2, userId: 2, streakId: 2, startDate: Date(), endDate: Date(), streak: streak2)

// Creating Business objects with all data
let business1 = Business(
    id: 1,
    name: "Business 1",
    categoryId: 1,
    image: "http://example.com/image1.png",
    question: "What is 2+2?",
    correctAnswer: "4",
    wrongAnswer1: "3",
    wrongAnswer2: "5",
    question2: "What is the capital of France?",
    correctAnswerQ2: "Paris",
    wrongAnswerQ2_1: "London",
    wrongAnswerQ2_2: "Berlin",
    locations: [location1],
    streaks: [streak1],
    rewards: [reward1],
    secretExperiences: [secretExperience1],
    category: category1
)

let business2 = Business(
    id: 2,
    name: "Business 2",
    categoryId: 2,
    image: "http://example.com/image2.png",
    question: "What is 3+3?",
    correctAnswer: "6",
    wrongAnswer1: "7",
    wrongAnswer2: "8",
    question2: "What is the capital of Germany?",
    correctAnswerQ2: "Berlin",
    wrongAnswerQ2_1: "Paris",
    wrongAnswerQ2_2: "Madrid",
    locations: [location2],
    streaks: [streak2],
    rewards: [reward2],
    secretExperiences: [secretExperience2],
    category: category2
)

// Array of Business objects
let businessesGlobal = [business1, business2]

// Print the array to verify the data



class HomeTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    //API CALL!
    
    
    let businesses = businessesGlobal

    // MARK: - Location Properties
    let locationManager = CLLocationManager()
    
    // Reseturent location
    let targetLatitude: CLLocationDegrees = 29.3581396  //from back
    let targetLongitude: CLLocationDegrees = 47.9070288  //from back 
    let targetRadius: CLLocationDistance = 50 // 40 meters
    
    var name = "Fatma"

    // Define the section titles
    let sections = [" ", "Today's Questions", "Rewards"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none

        tableView.register(StreaksTableViewCell.self, forCellReuseIdentifier: "StreaksTableViewCell")
        tableView.register(TodayPointTableViewCell.self, forCellReuseIdentifier: TodayPointTableViewCell.identifier)
        tableView.register(RewardsTableViewCell.self, forCellReuseIdentifier: RewardsTableViewCell.identifier)

        // Request Location Authorization
        setupLocationManager()
    }

    // MARK: - Location Setup
    func setupLocationManager() {
        locationManager.delegate = self
        // Request authorization
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }

    // MARK: - CLLocationManagerDelegate
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                DispatchQueue.global(qos: .background).async {
                    if CLLocationManager.locationServicesEnabled() {
                        DispatchQueue.main.async {
                            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                            self.locationManager.startUpdatingLocation()
                        }
                    } else {
                        print("Location services are not enabled")
                    }
                }
            case .notDetermined, .restricted, .denied:
                // Handle the case where the user has not granted location access
                print("Location access denied or restricted")
                break
            @unknown default:
                break
            }
        }

    
    private func startUpdatingLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else {
            print("No user location available")
            return
        }
        print("User location updated: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
        checkProximity(to: userLocation)
    }

    func checkProximity(to userLocation: CLLocation) {
        let targetLocation = CLLocation(latitude: targetLatitude, longitude: targetLongitude)
        let distance = userLocation.distance(from: targetLocation)

        print("Distance to target: \(distance) meters")

        if distance <= targetRadius {
            print("You are in the target area.")
        } else {
            print("You are not in the target area.")
        }
    }

    // MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count // Number of sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // One row per section
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section] // Section title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // First cell (StreaksTableViewCell)
            let cell = tableView.dequeueReusableCell(withIdentifier: "StreaksTableViewCell", for: indexPath) as! StreaksTableViewCell
            // Configure the cell
            cell.configure(streaks: 5)
            return cell
        } else if indexPath.section == 1 {
            // Second cell (TodayPointTableViewCell)
            let cell = tableView.dequeueReusableCell(withIdentifier: TodayPointTableViewCell.identifier, for: indexPath) as! TodayPointTableViewCell
            
            cell.name = name
            cell.businesses = businesses
            // Configure the cell if needed
            return cell
        } else if indexPath.section == 2 {
            // Third cell (RewardsTableViewCell)
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardsTableViewCell.identifier, for: indexPath) as! RewardsTableViewCell
            // Configure the cell
            return cell
        } else {
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            // Calculate height for the StreaksTableViewCell based on its content
            return 160
        } else if indexPath.section == 1 {
            // Calculate height for the TodayPointTableViewCell based on its content
            return 160
        } else if indexPath.section == 2 {
            return 180
        } else {
            return 160
        }
    }
}
