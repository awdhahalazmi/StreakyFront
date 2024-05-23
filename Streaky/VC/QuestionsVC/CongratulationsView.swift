import UIKit
import SnapKit

class CongratulationsView: UIView {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Congratulations!\nYou have earned 80 Points"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0)
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.masksToBounds = true
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addSubview(messageLabel)
        addSubview(doneButton)

        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.left.right.equalToSuperview().inset(16)
        }

        doneButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-32)
        }
    }

    @objc private func doneButtonTapped() {
        removeFromSuperview()
    }
}
