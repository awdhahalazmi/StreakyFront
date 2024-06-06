import UIKit
import SnapKit

class FriendsDashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var token: String?
    var user: User?

    private var friends: [Friend] = []
    private let requests: [Friend] = []
    private var currentList: [Friend]
    private var isRequestView: Bool = false

    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Friends", "Request"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = UIColor(red: 69/255, green: 30/255, blue: 123/255, alpha: 1)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 143/255, green: 91/255, blue: 215/255, alpha: 1)], for: .normal)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        return segmentedControl
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
        tableView.register(RequestTableViewCell.self, forCellReuseIdentifier: RequestTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.currentList = friends
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        self.currentList = friends
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        configureNavigationBarAppearance()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        view.addSubview(tableView)

        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "profile"),
            style: .plain,
            target: self,
            action: #selector(addFriendButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }

    private func configureNavigationBarAppearance() {
        title = "Friends"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor =  #colorLiteral(red: 0.6352165341, green: 0.402710855, blue: 0.9805307984, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Customize navigation bar appearance
        let appearance = UINavigationBarAppearance()
        title = "Friends"
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor =  #colorLiteral(red: 0.6352165341, green: 0.402710855, blue: 0.9805307984, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
       
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // Refresh the friends list
        getAllFriends()
    }

    @objc private func addFriendButtonTapped() {
        let addFriendVC = AddFriendViewController()
        navigationController?.pushViewController(addFriendVC, animated: true)
    }
    
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentList = friends
            isRequestView = false
        case 1:
            currentList = requests
            isRequestView = true
        default:
            break
        }
        tableView.reloadData()
    }

    func getAllFriends() {
        NetworkManager.shared.fetchAllFriends(token: UserDefaults.standard.string(forKey: "AuthToken") ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let friends):
                    self.friends = friends
                    self.currentList = self.isRequestView ? self.requests : self.friends
                    self.tableView.reloadData()
                case .failure:
                    print("Something went wrong in fetching friends")
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isRequestView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestTableViewCell.identifier, for: indexPath) as? RequestTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as? FriendTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: currentList[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FriendsDashboardViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            // Implement search functionality if needed
        } else {
            // Handle case when search text is empty
        }
        tableView.reloadData()
    }
}
