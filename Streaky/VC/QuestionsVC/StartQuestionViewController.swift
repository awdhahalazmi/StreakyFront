import UIKit
import SnapKit

class StartQuestionViewController: UIViewController {
    
    var questionsArray = ["How are you?", "How old are you?"]
    var questionNumber = 1
    
    private let readyLabel: UILabel = {
        let label = UILabel()
        label.text = "Get Ready!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's Question Awaits!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Now", for: .normal)
        button.backgroundColor = UIColor(red: 0.97, green: 0.47, blue: 0.34, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Adding shadow to the view to make it look like a popup
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 4
        view.addSubview(readyLabel)
        view.addSubview(questionLabel)
        view.addSubview(startButton)
        
        setupConstraints()
        
        print(questionsArray[questionNumber])
    }
    
    private func setupConstraints() {
        readyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.left.right.equalToSuperview().inset(16)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(readyLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc private func startButtonTapped() {
        // Handle button tap event
        let questionVC = QuestionViewController()
        questionVC.modalPresentationStyle = .fullScreen
        self.present(questionVC, animated: true, completion: nil)
    }
}
