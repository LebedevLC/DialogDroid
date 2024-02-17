//
//  RoleScreenViewController.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 17.02.2024.
//

import UIKit

final class RoleScreenViewController: UIViewController {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    @IBOutlet private weak var tableView: UITableView!
    private var selectedIndex: IndexPath?
    
    private let settingsStorage: ApplicationSettings = DefaultServicesProvider.shared.settingsStorage
    
    private let model = ChatRole.allCases
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        let indexPath = IndexPath(row: settingsStorage.selectedRoleIndex, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        tableView.cellForRow(at: indexPath)?.isSelected = true
        selectedIndex = indexPath
    }
    
    // MARK: - Actions
    
    @IBAction private func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "RoleScreenTableViewCell", bundle: nil),
            forCellReuseIdentifier: "RoleScreenTableViewCell"
        )
    }
}

// MARK: - UITableViewDataSource

extension RoleScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RoleScreenTableViewCell",
            for: indexPath
        ) as? RoleScreenTableViewCell else {
            return UITableViewCell()
        }
        let role = model[indexPath.row]
        cell.configure(title: role.title, description: role.description)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RoleScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndex {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.cellForRow(at: selectedIndex)?.isSelected = false
        }
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        tableView.cellForRow(at: indexPath)?.isSelected = true
        selectedIndex = indexPath
        settingsStorage.selectedRoleIndex = indexPath.row
    }
}
