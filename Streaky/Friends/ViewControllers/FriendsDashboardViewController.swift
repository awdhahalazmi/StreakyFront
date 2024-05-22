import UIKit
import SnapKit

class FriendsDashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let friends: [Friend] = [
        Friend(name: "Fatma", profileImageUrl: "https://example.com/image1.jpg", lastStreakLocation: "Pick", streakCount: 5),
        Friend(name: "Awdlah", profileImageUrl: "https://example.com/image2.jpg", lastStreakLocation: "Coffee Bean", streakCount: 4),
        Friend(name: "Faten", profileImageUrl: "https://example.com/image3.jpg", lastStreakLocation: "Pick", streakCount: 3),
        Friend(name: "Noura", profileImageUrl: "https://example.com/image4.jpg", lastStreakLocation: "Ananas", streakCount: 2),
        Friend(name: "Maha", profileImageUrl: "https://example.com/image5.jpg", lastStreakLocation: "Spark", streakCount: 1)
    ]

    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Request", "Friends"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = UIColor(red: 69/255, green: 30/255, blue: 123/255, alpha: 1)
        segmentedControl.layer.cornerRadius = 20
        segmentedControl.layer.masksToBounds = true
        return segmentedControl
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: FriendTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()

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
            image: UIImage(systemName: "person.fill.badge.plus"),
            style: .plain,
            target: self,
            action: #selector(addFriendButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white

       
    }

    private func configureNavigationBarAppearance() {
        title = "Friends Dashboards"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 92/255, green: 40/255, blue: 164/255, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true
    }


    @objc private func addFriendButtonTapped() {
        let addFriendVC = AddFriendViewController()
        navigationController?.pushViewController(addFriendVC, animated: true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as? FriendTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: friends[indexPath.row])
        return cell
    }
}
