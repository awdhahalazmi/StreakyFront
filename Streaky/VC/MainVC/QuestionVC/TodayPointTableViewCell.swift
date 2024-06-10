import UIKit
import CoreLocation
import SnapKit

// Bridge
protocol CustomTableViewCellDelegate: AnyObject {
    func collectionViewCellTapped(at indexPath: IndexPath)
}

class TodayPointTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    var businesses: [Business] = []
    static let identifier = "TodayPointTableViewCell"
    weak var delegate: CustomTableViewCellDelegate?
    
    var userLocation: CLLocation?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let locationManager = CLLocationManager()
    
    private var isNearLocation = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
        getCurrentLocation()
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TodayPointCollectionViewCell.self, forCellWithReuseIdentifier: "TodayPointCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
    }
    
    func configure(with streaks: [Streak]) {
        self.businesses = streaks.flatMap { $0.businesses }
        collectionView.reloadData()
    }
    
    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            print("Location services are not enabled")
        }
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(160)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.userLocation = location
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return businesses.count

    }
    
    func checkProximity(userLocation: CLLocation?, storeLocation: Location?) -> Bool {
        if(userLocation == nil || storeLocation == nil) {
            return false
        }
        
        let storeCLLocation = CLLocation(latitude: storeLocation!.latitude, longitude: storeLocation!.longitude)
        let distance = userLocation!.distance(from: storeCLLocation)
        
        let isInProximity = distance <= storeLocation!.radius
        
        if isInProximity {
            print(storeLocation!.latitude)
            print("User is at the place: \(storeLocation!.name)")

        } else {
            print("User is not at the place")
            
        }
        
        print("Distance to target: \(distance) meters")
        return isInProximity
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayPointCollectionViewCell", for: indexPath) as! TodayPointCollectionViewCell
        let business = businesses[indexPath.item]
        let isWithinLocation = checkProximity(userLocation: userLocation, storeLocation: business.locations.first)
        cell.configure(with: business, isWithinLocation: isWithinLocation)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 60) / 2.5
        return CGSize(width: width + 45, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        delegate?.collectionViewCellTapped(at: indexPath)
    }
}

