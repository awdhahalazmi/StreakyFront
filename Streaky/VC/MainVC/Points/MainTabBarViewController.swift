import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        configureTabBarAppearance()
        callHome()
    }

    func setupViewControllers() {
        
        
        
        let HomeTableViewController = HomeTableViewController()
        HomeTableViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "sparkles"),
            selectedImage: UIImage(systemName: "bubbles.and.sparkles.fill")
        )
        
        let friendsViewController = FriendsDashboardViewController()
        friendsViewController.tabBarItem = UITabBarItem(
            title: "Friends",
            image: UIImage(systemName: "person.2"),
            selectedImage: UIImage(systemName: "person.2.fill")
        )
        

        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        viewControllers = [HomeTableViewController,friendsViewController, profileViewController]
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
        let navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.modalPresentationStyle = .fullScreen

        self.present(navigationController, animated: true, completion: nil)
        
    }
}
