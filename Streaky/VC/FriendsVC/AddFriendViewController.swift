import UIKit
import SnapKit

protocol AddFriendCellDelegate: AnyObject {
    func didTapAddButton(for friend: Friend)
}

class AddFriendViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, AddFriendCellDelegate {
    
    private var friends: [Friend] = [
        //        Friend(name: "Fatma", profileImageUrl: "https://example.com/image1.jpg", lastStreakLocation: "Pick", streakCount: 5),
        //        Friend(name: "Awdlah", profileImageUrl: "https://example.com/image2.jpg", lastStreakLocation: "Coffee Bean", streakCount: 4)
    ]
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundImage = UIImage()
        searchBar.layer.cornerRadius = 8
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AddFriendTableViewCell.self, forCellReuseIdentifier: AddFriendTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureNavigationBar()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        fetchFriends()
    }
    
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        title = "Add Friends"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor =  #colorLiteral(red: 0.6352165341, green: 0.402710855, blue: 0.9805307984, alpha: 1)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddFriendTableViewCell.identifier, for: indexPath) as? AddFriendTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: friends[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func didTapAddButton(for friend: Friend) {
        let alertController = UIAlertController(title: "Add Friend", message: "Do you want to add \(friend.name) as a friend?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            print("\(friend.name) added as a friend.")
        }))
        present(alertController, animated: true, completion: nil)
    }
    private func fetchFriends() {
        
        NetworkManager.shared.fetchAllFriends(token: UserDefaults.standard.string(forKey: "AuthToken") ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let friends):
                    self.friends = friends
                    //                    self.filteredFriends = friends
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Failed to fetch friends: \(error)")
                }
            }
        }
    }
    
}
