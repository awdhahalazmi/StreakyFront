import UIKit
import CoreLocation
import SnapKit
/*
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

*/

class TodayPointTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    static let identifier = "TodayPointTableViewCell"

    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let locationManager = CLLocationManager()
    private let targetLocation = CLLocation(latitude: 50, longitude: -50) // Example coordinates
    private var isNearLocation = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
        setupLocationManager()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TodayPointCollectionViewCell.self, forCellWithReuseIdentifier: "TodayPointCollectionViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
    
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo((contentView))
            make.leading.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(160)
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        let distance = userLocation.distance(from: targetLocation)
        isNearLocation = distance <= 100
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayPointCollectionViewCell", for: indexPath) as! TodayPointCollectionViewCell
        let points = (indexPath.item + 1) * 10
        let brand = "Brand \(indexPath.item + 1)"
        cell.configure(points: points, brand: brand, latitude: 50, longitude: 50)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 60) / 2.5
        return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}



class TodayPointCollectionViewCell: UICollectionViewCell {
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 0.9877220988, green: 0.7017197013, blue: 0.3189855218, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.9998729825, green: 0.9553380609, blue: 0.8998980522, alpha: 1)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let goButton: UIButton = {
        let button = UIButton()
        button.setTitle("GO", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.8982707858, blue: 0.7560862899, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.fill")
        imageView.tintColor = .orange
        imageView.isUserInteractionEnabled = true // Enable user interaction
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(pointsLabel)
        containerView.addSubview(brandLabel)
        containerView.addSubview(goButton)
        containerView.addSubview(locationIcon)
        setupGestureRecognizers()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.top.equalTo(pointsLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        goButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        locationIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openGoogleMaps))
        locationIcon.addGestureRecognizer(tapGesture)
    }
    
    @objc private func openGoogleMaps() {
        // Open Google Maps with the target location coordinates
        let latitude = 60.4720 // Replace with your target location's latitude
        let longitude = 8.1 // Replace with your target location's longitude
        if let url = URL(string: "comgooglemaps://?q=\(latitude),\(longitude)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // If Google Maps is not installed, open in Safari
                let safariUrl = URL(string: "https://www.google.com/maps?q=\(latitude),\(longitude)")!
                UIApplication.shared.open(safariUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
    func configure(points: Int, brand: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        pointsLabel.text = "Get \(points) points"
        brandLabel.text = brand
        
        // Create CLLocation object for the target location
        let targetLocation = CLLocation(latitude: 50, longitude: 50)
        
        // Calculate the distance between the user's location and the target location
        let userLocation = CLLocation(latitude: latitude, longitude: longitude)
        let distance = userLocation.distance(from: targetLocation)
        
        // Set a radius (in meters) around the target location
        let radius: CLLocationDistance = 5.0
        
        // Check if the distance is within the radius
        let isWithinRadius = distance <= radius
        
        // Enable the button if the user is within the radius, disable otherwise
        goButton.isEnabled = isWithinRadius
        goButton.backgroundColor = isWithinRadius ? .orange : #colorLiteral(red: 1, green: 0.8982707858, blue: 0.7560862899, alpha: 1)
    }
}
