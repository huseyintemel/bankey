//
//  AccountSummaryViewController.swift
//  bankey
//
//  Created by huseyin on 4.07.2023.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    var accounts: [Account] = []
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    var profile: Profile?
    
    var tableView = UITableView()
    let headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshController = UIRefreshControl()
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
        setupRefreshControl()
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        
        Task {
            await fetchProfile(forUserId: "1")
            await fetchAccounts(forUserId: "1")
        }
        
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseId)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    private func setupRefreshControl() {
        refreshController.tintColor = appColor
        refreshController.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshController
    }
    
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else { return UITableViewCell() }
                
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseId, for: indexPath) as! AccountSummaryCell
        let account = accountCellViewModels[indexPath.row]
        cell.configure(with: account)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AccountSummaryViewController {
    
    func fetchAccounts(forUserId userId: String) async {
        let url = "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts"

        do {
            self.accounts = try await NetworkManager.shared.fetchData(from: url, responseType: [Account].self)
            self.configureTableCells(with: accounts)
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        } catch {
                print("Error: \(error)")
        }
        
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }
    
    
    func fetchProfile(forUserId userId: String) async {
        let url = "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)"

        do {
            self.profile = try await NetworkManager.shared.fetchData(from: url, responseType: Profile.self)
            self.configureTableHeaderView(with: profile!)
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        } catch {
                print("Error: \(error)")
        }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
           let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                       name: profile.firstName,
                                                       date: Date())
           headerView.configure(viewModel: vm)
       }
}

extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshContent() {
        Task {
            let userId = String(Int.random(in: 1..<4))
            await fetchProfile(forUserId: userId)
            await fetchAccounts(forUserId: userId)
        }
    }
}
