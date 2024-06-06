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
        self.selectedIndex = 0
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
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )
        
        let profileViewController = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        viewControllers = [homeNavigationController, friendsNavigationController, profileNavigationController]
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
}
