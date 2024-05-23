import UIKit

class WelcomeViewController: UIViewController {
    
    var backgroundImageView: UIImageView!

    private let splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo") // Ensure this image is in your assets
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSplashImageView()
        setupLogoImageView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showOnboardingScreen()
        }
    }
    
    private func setupSplashImageView() {
        view.addSubview(splashImageView)
        NSLayoutConstraint.activate([
            splashImageView.topAnchor.constraint(equalTo: view.topAnchor),
            splashImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            splashImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splashImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLogoImageView() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200), // Adjust the width as needed
            logoImageView.heightAnchor.constraint(equalToConstant: 200) // Adjust the height as needed
        ])
    }
    
    private func showOnboardingScreen() {
        let onboardingVC = OnboardingViewController()
        let navigationController = UINavigationController(rootViewController: onboardingVC)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = navigationController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion: nil)
        }
    }
}
