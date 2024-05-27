import UIKit
import SnapKit

class QuestionViewController: UIViewController {
    
    private var points: Int = 0
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
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
    private let incorrectAnswerColor = UIColor(red: 238/255, green: 100/255, blue: 100/255, alpha: 1)
    private let selectedAnswerColor = UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1)
    
    private var questions: [(question: String, options: [String], correctAnswer: String)] = [
        ("What is the latest released in Pick", ["Tramisu Latte", "Con Panna", "Pum Berry Sauce", "Schiaccatta"], "Pum Berry Sauce"),
        ("What is the capital of France?", ["Berlin", "Madrid", "Paris", "Rome"], "Paris"),
        
    ]
    
    private var currentQuestionIndex = 0
    private var selectedAnswer: String?
    private var incorrectAnswers = 0
    
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
            make.top.equalTo(todayQuestionLabel.snp.bottom).offset(32)
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
            showAlert(message: "Please select an answer.")
            return
        }
        
        let questionData = questions[currentQuestionIndex]
        if selectedAnswer == questionData.correctAnswer {
            highlightCorrectAnswer()
            points += 50 
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.showCongratulations()
            }
        } else {
            highlightIncorrectAnswer()
            incorrectAnswers += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if self.incorrectAnswers == 2 {
                    self.showTryAgain()
                } else {
                    self.currentQuestionIndex += 1
                    self.loadQuestion()
                }
            }
        }
    }
    
    private func highlightCorrectAnswer() {
        for button in stackView.arrangedSubviews as! [UIButton] {
            if button.title(for: .normal) == selectedAnswer {
                button.layer.borderColor = correctAnswerColor.cgColor
                button.backgroundColor = correctAnswerColor.withAlphaComponent(0.2)
            }
        }
    }
    
    private func highlightIncorrectAnswer() {
        for button in stackView.arrangedSubviews as! [UIButton] {
            if button.title(for: .normal) == selectedAnswer {
                button.layer.borderColor = incorrectAnswerColor.cgColor
                button.backgroundColor = incorrectAnswerColor.withAlphaComponent(0.2)
            }
        }
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showCongratulations() {
        hideQuestions()
        let congratulationsView = createCongratulationsView()
        view.addSubview(congratulationsView)
        
        congratulationsView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(200)
        }
    }
    
    private func showTryAgain() {
        hideQuestions()
        let tryAgainView = createTryAgainView()
        view.addSubview(tryAgainView)
        
        tryAgainView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(200)
        }
    }
    
    private func hideQuestions() {
        todayQuestionLabel.isHidden = true
        containerView.isHidden = true
        submitButton.isHidden = true
    }
    
    private func configureNavigationBar() {
        title = ""
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func createCongratulationsView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = "Congratulations!\nYou have earned 50 Points"
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
        
        let doneButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Done", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0)
            button.layer.cornerRadius = 22
            button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
            return button
        }()
        
        view.addSubview(messageLabel)
        view.addSubview(doneButton)
        
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
        
        return view
    }
    
    private func createTryAgainView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = "Thanks for your effort!\nTry again Tomorrow"
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
        
        let doneButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Done", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 1.0, green: 0.6, blue: 0.4, alpha: 1.0)
            button.layer.cornerRadius = 22
            button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
            return button
        }()
        
        view.addSubview(messageLabel)
        view.addSubview(doneButton)
        
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
        
        return view
    }
    
    @objc private func doneButtonTapped() {
        if let view = view.subviews.last {
            view.removeFromSuperview()
        }
        let pointsVC = PointsViewController(points: points)
        navigationController?.pushViewController(pointsVC, animated: true)
    }
}
