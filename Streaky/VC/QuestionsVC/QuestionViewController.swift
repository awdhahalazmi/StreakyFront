import UIKit
import SnapKit

class QuestionViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background") // Replace with your image name
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private let todayQuestionLabel: UILabel = {
        let label = UILabel()
        label.text = "Today Question"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question 1"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .orange
        label.textAlignment = .left
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 69/255, green: 30/255, blue: 123/255, alpha: 1)
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "You must choose one answer"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let correctAnswerColor = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1)
    private let selectedAnswerColor = UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1)
    
    private var questions: [(question: String, options: [String], correctAnswer: String)] = [
        ("What is the latest released in Pick", ["Tramisu Latte", "Con Panna", "Pum Berry Sauce", "Schiaccatta"], "Pum Berry Sauce"),
        ("What is the capital of France?", ["Berlin", "Madrid", "Paris", "Rome"], "Paris"),
        // Add more questions here
    ]
    
    private var currentQuestionIndex = 0
    private var selectedAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadQuestion()
    }
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(todayQuestionLabel)
        view.addSubview(containerView)
        view.addSubview(submitButton)
        
        containerView.addSubview(questionLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(stackView)
        containerView.addSubview(instructionLabel)
        
        configureNavigationBar()
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        todayQuestionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(todayQuestionLabel.snp.bottom).offset(32) // Moved down
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(400)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
    }
    
    private func loadQuestion() {
        guard currentQuestionIndex < questions.count else {
            // Handle end of questions
            return
        }
        
        let questionData = questions[currentQuestionIndex]
        questionLabel.text = "Question \(currentQuestionIndex + 1)"
        titleLabel.text = questionData.question
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for option in questionData.options {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.cornerRadius = 8
            button.contentHorizontalAlignment = .left
            button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            button.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        selectedAnswer = nil
    }
    
    @objc private func optionButtonTapped(_ sender: UIButton) {
        selectedAnswer = sender.title(for: .normal)
        for button in stackView.arrangedSubviews as! [UIButton] {
            button.layer.borderColor = UIColor.gray.cgColor
            button.backgroundColor = .clear
        }
        sender.layer.borderColor = selectedAnswerColor.cgColor
        sender.backgroundColor = selectedAnswerColor.withAlphaComponent(0.2)
    }
    
    @objc private func submitButtonTapped() {
        guard let selectedAnswer = selectedAnswer else {
            showAlert(message: "Please select an answer.", isCorrect: false)
            return
        }
        
        let questionData = questions[currentQuestionIndex]
        if selectedAnswer == questionData.correctAnswer {
            if currentQuestionIndex == questions.count - 1 {
                showCongratulations()
            } else {
                currentQuestionIndex += 1
                loadQuestion()
            }
        } else {
            currentQuestionIndex += 1
            loadQuestion()
        }
    }
    
    private func showAlert(message: String, isCorrect: Bool) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showCongratulations() {
        let congratulationsView = CongratulationsView()
        view.addSubview(congratulationsView)
        
        congratulationsView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(200)
        }
    }
    
    private func configureNavigationBar() {
        title = ""
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
