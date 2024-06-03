import UIKit
import SnapKit

class StreaksTableViewCell: UITableViewCell {
    
    // UI Components
    let flameIcon = UIImageView()
    let streakNumberLabel = UILabel()
    let streakDescriptionLabel = UILabel()
    var statusIcons: [UIImageView] = []
    
    // Constants
    let flameIconSize: CGFloat = 40
    let statusIconSize: CGFloat = 16
    let numberOfStatusIcons = 7
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        // Configure cell corner radius
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        
        // Configure flame icon
        flameIcon.image = UIImage(systemName: "flame.fill")
        flameIcon.tintColor = .orange
        flameIcon.contentMode = .scaleAspectFit
        contentView.addSubview(flameIcon)
        
        // Configure streak number label
        streakNumberLabel.font = UIFont.boldSystemFont(ofSize: 32)
        streakNumberLabel.textColor = .black
        contentView.addSubview(streakNumberLabel)
        
        // Configure streak description label
        streakDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        streakDescriptionLabel.textColor = .gray
        streakDescriptionLabel.text = "Days streaks"
        contentView.addSubview(streakDescriptionLabel)
        
        // Configure status icons
        for _ in 0..<numberOfStatusIcons {
            let statusIcon = UIImageView()
            statusIcon.image = UIImage(systemName: "circle.fill")
            statusIcon.tintColor = .lightGray
            statusIcon.layer.cornerRadius = 12.5 // Half of the statusIconSize
            statusIcon.clipsToBounds = true
            contentView.addSubview(statusIcon)
            statusIcons.append(statusIcon)
        }
    }
    
    private func setupConstraints() {
        flameIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(80)
        }
        
        streakNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(flameIcon.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(30)
        }
        
        streakDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(streakNumberLabel.snp.leading)
            make.top.equalTo(streakNumberLabel.snp.bottom).offset(4)
        }
        
        for (index, statusIcon) in statusIcons.enumerated() {
            statusIcon.snp.makeConstraints { make in
                if index == 0 {
                    make.leading.equalToSuperview().offset(28)
                } else {
                    make.leading.equalTo(statusIcons[index - 1].snp.trailing).offset(8)
                }
                make.top.equalTo(flameIcon.snp.bottom).offset(16)
                make.width.height.equalTo(25)
            }
        }
        self.backgroundColor = .clear
        self.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.selectionStyle = .none
        
    }
    
    func configure(streaks: Int) {
        streakNumberLabel.text = " \(streaks)"
        
        for (index, statusIcon) in statusIcons.enumerated() {
            if index < streaks {
                statusIcon.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            } else {
                statusIcon.tintColor = .lightGray
            }
            
        }
    }
}
