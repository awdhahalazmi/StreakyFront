import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the main view
        view.backgroundColor = .white
        
        // Set up and add the StreaksViewController
        let streaksViewController = StreaksTableViewController()
        addChild(streaksViewController)
        view.addSubview(streaksViewController.view)
        streaksViewController.didMove(toParent: self)
        
        // Set up constraints for the streaksViewController's view using SnapKit
        streaksViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

