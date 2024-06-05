import UIKit

class MainTabBarViewController: UITabBarController {

    var token: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        configureTabBarAppearance()
        if let savedToken = UserDefaults.standard.string(forKey: "AuthToken") {
            token = savedToken
        }
        callHome()
        self.selectedIndex = 1
        
    }

    func setupViewControllers() {
        let homeTableViewController = HomeTableViewController()
        let homeNavigationController = UINavigationController(rootViewController: homeTableViewController)
        homeNavigationController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "sparkles"),
            selectedImage: UIImage(systemName: "bubbles.and.sparkles.fill")
        )
        
        let friendsViewController = FriendsDashboardViewController()
        let friendsNavigationController = UINavigationController(rootViewController: friendsViewController)
        friendsNavigationController.tabBarItem = UITabBarItem(
            title: "Friends",
            image: UIImage(systemName: "person.3.sequence"),
            selectedImage: UIImage(systemName: "person.3.sequence.fill")
        )
        
        let profileViewController = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        viewControllers = [homeNavigationController, friendsViewController, profileNavigationController]

    }


    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.tintColor = UIColor(red: 92/255, green: 40/255, blue: 164/255, alpha: 1.0)
        tabBar.unselectedItemTintColor = UIColor(white: 1.0, alpha: 0.6)
    }
    
    func callHome()
    {
        let homeVC = HomeTableViewController()
        homeVC.token = "AuthToken" // Pass the token to GymListTableViewController
//                    let TabBarVC = TabBarViewController()
//                    TabBarVC.token = tokenResponse.token // You can also pass the token to other view controllers if needed
        self.navigationController?.pushViewController(homeVC, animated: true)
//        let navigationController = UINavigationController(rootViewController: homeVC)
//        navigationController.modalPresentationStyle = .fullScreen
//
//        self.present(navigationController, animated: true, completion: nil)
        
    }
}
