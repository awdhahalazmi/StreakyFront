import UIKit
import CoreLocation
import SnapKit


// Bridge
protocol CustomTableViewCellDelegate: AnyObject {
    func collectionViewCellTapped(at indexPath: IndexPath)
}

class TodayPointTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    var streaks : [Streak] = []
    static let identifier = "TodayPointTableViewCell"
    weak var delegate: CustomTableViewCellDelegate?
    
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
        //collectionView.backgroundColor = #colorLiteral(red: 0.8908624053, green: 0.8414362073, blue: 0.9621829391, alpha: 0.3082763672)
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
        self.streaks = streaks
        collectionView.reloadData()
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
        return CGSize(width: width+45, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.collectionViewCellTapped(at: indexPath)
        
    }

    
}

