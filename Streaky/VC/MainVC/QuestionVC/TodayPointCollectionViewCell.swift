import UIKit
import SnapKit
import CoreLocation
import MapKit

class TodayPointCollectionViewCell: UICollectionViewCell {

    var location: Location?
    var business: Business?
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .orange
        label.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 0.3300537109)
        label.layer.cornerRadius = 12
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
        button.backgroundColor = #colorLiteral(red: 0.9829108119, green: 0.5975590348, blue: 0.4170847535, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.circle.fill")
        imageView.tintColor = #colorLiteral(red: 0.9829108119, green: 0.5975590348, blue: 0.4170847535, alpha: 1)
        imageView.isUserInteractionEnabled = true // Enable user interaction
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        googleMapsGestureRecognizers()
        pointsLabel.text = " 50 Points"

    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(80)
            make.height.equalTo(24)
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
    
    // MARK: Google Map Functionality
    private func googleMapsGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openGoogleMaps))
        locationIcon.addGestureRecognizer(tapGesture)
    }
    
    @objc private func openGoogleMaps() {
        if(business == nil || location == nil) {
            return
        }
        
        let latitude: CLLocationDegrees = location!.latitude
        let longitude: CLLocationDegrees = location!.longitude
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = business!.name
        mapItem.openInMaps(launchOptions: options)
        
        // Open Google Maps with the target location coordinates
//        let latitude = 48.1538771 // Replace with your target location's latitude
//        let longitude = 29.2966025 // Replace with your target location's longitude
//        if let url = URL(string: "https://www.google.com/maps/@29.2963536,48.1542202") {
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            } else {
//                // If Google Maps is not installed, open in Safari
//                let safariUrl = URL(string: "https://www.google.com/maps?q=\(latitude),\(longitude)")!
//                UIApplication.shared.open(safariUrl, options: [:], completionHandler: nil)
//            }
//        }
    }
    
    // MARK: Go Button Functionality
    private func goGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openGoogleMaps))
        locationIcon.addGestureRecognizer(tapGesture)
    }
    
    func configure(with business: Business, isWithinLocation: Bool) {
        self.business = business
        brandLabel.text = business.name
        self.location = business.locations.first
        
        // Enable the button if the user is within the radius, disable otherwise
        goButton.isEnabled = isWithinLocation
        goButton.backgroundColor = isWithinLocation ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) : #colorLiteral(red: 0.9829108119, green: 0.5975590348, blue: 0.4170847535, alpha: 0.6094970703)
        
    }
    
}
