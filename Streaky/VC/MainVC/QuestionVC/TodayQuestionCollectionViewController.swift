import UIKit
import CoreLocation
import SnapKit

class TodayQuestionCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    // UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's Questions"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 1.0, green: 0.95, blue: 0.87, alpha: 1.0) // Light background color
        return collectionView
    }()
    
    // Location Manager instance
    private let locationManager = CLLocationManager()
    
    // Target location coordinates (replace with your actual coordinates)
    private let targetLocation = CLLocation(latitude: 50, longitude: 50)
    
    // Button color
    private var isNearLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupLocationManager()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TodayQuestionCollectionViewCell.self, forCellWithReuseIdentifier: "TodayQuestionCollectionViewCell")
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(160) // Adjust height as needed
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // CLLocationManagerDelegate method to handle location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        let distance = userLocation.distance(from: targetLocation)
        // Assuming 100 meters as the threshold for being near the location, adjust this value as needed
        isNearLocation = distance <= 100
        
        // Update button color based on proximity to target location
        collectionView.reloadData() // Refresh collection view to update button color
    }
    
    // UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // Example number of items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayQuestionCollectionViewCell", for: indexPath) as! TodayQuestionCollectionViewCell
        // Example configuration
        let points = (indexPath.item + 1) * 10
        let brand = "Brand \(indexPath.item + 1)"
        // Pass the desired latitude and longitude values
        cell.configure(points: points, brand: brand, latitude: 50, longitude: 50, viewController: self)
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - -60) / 2.5 // Adjusted for wider container
        return CGSize(width: width, height: 150) // Adjust height as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16 // Adjust spacing between items
    }
}
