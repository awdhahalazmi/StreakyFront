import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    // Target location coordinates
    let targetLatitude: CLLocationDegrees = 29.3579166
    let targetLongitude: CLLocationDegrees = 47.9071659
    let targetRadius: CLLocationDistance = 40

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getCurrentLocation()
    }
    
    func getCurrentLocation() {
        locationManager.delegate = self
        
        // Request authorization
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            print("Location services are not enabled")
        }
    }
}

extension LocationViewController {
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
}
