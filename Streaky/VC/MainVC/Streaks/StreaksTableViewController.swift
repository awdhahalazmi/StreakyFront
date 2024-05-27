import UIKit
import SnapKit

class StreaksTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none // Remove all separators
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        tableView.register(StreaksTableViewCell.self, forCellReuseIdentifier: "StreaksTableViewCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Example number of rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StreaksTableViewCell", for: indexPath) as! StreaksTableViewCell
        
        //MARK: Configuring the cell
        
        cell.configure(streaks: 5)

//        // Remove cell selection style to avoid visible border effect when selected
//        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160 // Adjust height according to design
    }
}
