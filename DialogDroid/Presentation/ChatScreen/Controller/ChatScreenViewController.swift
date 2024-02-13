//
//  ChatScreenViewController.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 13.02.2024.
//

import UIKit

final class ChatScreenViewController: UIViewController {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var inputContainerView: UIView!
    
    private let servicesProvider: ServicesProvider = DefaultServicesProvider.shared
    
    private var model: [MessageModel] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        configureNavigationBar()
    }
    
    // MARK: - Public Methods
    
    // MARK: - Actions
    
    @IBAction private func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        navigationItem.title = "Chat screen"
    }
    
    private func configureTableView() {
        do {
            model = try servicesProvider.coreDataManager.getAllChatMessages()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ChatScreenTableViewCell.self, forCellReuseIdentifier: "ChatScreenTableViewCell")
            tableView.reloadData()
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
        } catch {
            print(error)
        }
    }
}

// MARK: - UITableViewDataSource

extension ChatScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChatScreenTableViewCell",
            for: indexPath
        ) as? ChatScreenTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(from: model[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChatScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
