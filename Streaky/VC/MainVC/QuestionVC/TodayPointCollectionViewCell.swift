//
//  TodayPointCollectionViewCell.swift
//  Streaky
//
//  Created by Fatma Buyabes on 29/05/2024.
//

import UIKit
import CoreLocation


class TodayPointCollectionViewCell: UICollectionViewCell {
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = #colorLiteral(red: 1, green: 0.5878451467, blue: 0.005192696583, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 0.1781005859)
        label.layer.cornerRadius = 5
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
        button.backgroundColor =  #colorLiteral(red: 0.9829108119, green: 0.5975590348, blue: 0.4170847535, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.circle.fill")
        imageView.tintColor =  #colorLiteral(red: 1, green: 0.8982707858, blue: 0.7560862899, alpha: 1)
        imageView.isUserInteractionEnabled = true // Enable user interaction
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.5
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
        goButton.backgroundColor = isWithinRadius ?  #colorLiteral(red: 0.9829108119, green: 0.5975590348, blue: 0.4170847535, alpha: 1): #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)

    }
}


