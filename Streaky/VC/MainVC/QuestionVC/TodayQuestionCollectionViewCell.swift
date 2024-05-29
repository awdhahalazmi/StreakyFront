//import UIKit
//import CoreLocation
//
//class TodayQuestionCollectionViewCell: UICollectionViewCell {
//    
//    private let pointsLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        label.textColor = #colorLiteral(red: 0.9877220988, green: 0.7017197013, blue: 0.3189855218, alpha: 1)
//        label.backgroundColor = #colorLiteral(red: 0.9998729825, green: 0.9553380609, blue: 0.8998980522, alpha: 1)
//        label.layer.cornerRadius = 8
//        label.layer.masksToBounds = true
//        label.textAlignment = .center
//        label.setContentHuggingPriority(.required, for: .horizontal)
//        label.setContentCompressionResistancePriority(.required, for: .horizontal)
//        return label
//    }()
//    
//    private let brandLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        label.textColor = .black
//        label.textAlignment = .left
//        return label
//    }()
//    
//    let goButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("GO", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
//        button.backgroundColor = #colorLiteral(red: 1, green: 0.8982707858, blue: 0.7560862899, alpha: 1)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 8
//        return button
//    }()
//    
//    private let locationIcon: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "location.fill")
//        imageView.tintColor = .orange
//        imageView.isUserInteractionEnabled = true // Enable user interaction
//        return imageView
//    }()
//    
//    private let containerView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 16
//        view.layer.borderWidth = 0.5
//        view.layer.borderColor = UIColor.white.cgColor
//        view.layer.shadowRadius = 1
//        view.layer.shadowOpacity = 0.2
//        view.layer.shadowColor = UIColor.lightGray.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 4)
//        view.backgroundColor = .white
//        return view
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        contentView.addSubview(containerView)
//        containerView.addSubview(pointsLabel)
//        containerView.addSubview(brandLabel)
//        containerView.addSubview(goButton)
//        containerView.addSubview(locationIcon)
//        setupGestureRecognizers()
//    }
//    
//    private func setupConstraints() {
//        containerView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(4)
//        }
//        
//        pointsLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(16)
//            make.leading.equalToSuperview().offset(16)
//        }
//        
//        brandLabel.snp.makeConstraints { make in
//            make.top.equalTo(pointsLabel.snp.bottom).offset(8)
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().offset(-16)
//        }
//        
//        goButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(16)
//            make.bottom.equalToSuperview().offset(-16)
//            make.width.equalTo(50)
//            make.height.equalTo(30)
//        }
//        
//        locationIcon.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-16)
//            make.bottom.equalToSuperview().offset(-16)
//            make.width.height.equalTo(24)
//        }
//    }
//    
//    private func setupGestureRecognizers() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openGoogleMaps))
//        locationIcon.addGestureRecognizer(tapGesture)
//    }
//    
//    @objc private func openGoogleMaps() {
//        // Open Google Maps with the target location coordinates
//        let latitude = 60.4720 // Replace with your target location's latitude
//        let longitude = 8.1 // Replace with your target location's longitude
//        if let url = URL(string: "comgooglemaps://?q=\(latitude),\(longitude)") {
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            } else {
//                // If Google Maps is not installed, open in Safari
//                let safariUrl = URL(string: "https://www.google.com/maps?q=\(latitude),\(longitude)")!
//                UIApplication.shared.open(safariUrl, options: [:], completionHandler: nil)
//            }
//        }
//    }
//    
//    func configure(points: Int, brand: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, viewController: UIViewController) {
//        pointsLabel.text = "Get \(points) points"
//        brandLabel.text = brand
//        
//        // Create CLLocation object for the target location
//        let targetLocation = CLLocation(latitude: 50, longitude: 50)
//        
//        // Calculate the distance between the user's location and the target location
//        let userLocation = CLLocation(latitude: latitude, longitude: longitude)
//        let distance = userLocation.distance(from: targetLocation)
//        
//        // Set a radius (in meters) around the target location
//        let radius: CLLocationDistance = 5.0
//        
//        // Check if the distance is within the radius
//        let isWithinRadius = distance <= radius
//        
//        // Enable the button if the user is within the radius, disable otherwise
//        goButton.isEnabled = isWithinRadius
//        goButton.backgroundColor = isWithinRadius ? .orange : #colorLiteral(red: 1, green: 0.8982707858, blue: 0.7560862899, alpha: 1)
//        
//        // Add action to goButton
//        goButton.addAction(UIAction { [weak viewController] _ in
//            let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to start?", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
//                let questionVC = QuestionViewController() // Replace with your target view controller
//                viewController?.navigationController?.pushViewController(questionVC, animated: true)
//            }))
//            
//            viewController?.present(alertController, animated: true, completion: nil)
//        }, for: .touchUpInside)
//    }
//}
