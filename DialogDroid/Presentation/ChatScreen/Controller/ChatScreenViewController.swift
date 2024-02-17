//
//  ChatScreenViewController.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 13.02.2024.
//

import UIKit

final class ChatScreenViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var mainView: ChatScreenView = {
        let view = ChatScreenView()
        view.tableView.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let servicesProvider: ServicesProvider = DefaultServicesProvider.shared
    
    private var model: [MessageModel] = []
    private var lastIndex: IndexPath? {
        guard !model.isEmpty else { return nil }
        return IndexPath(row: model.count - 1, section: 0)
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        configureNavigationBar()
        mainView.setRoleTitle(ChatRole(rawValue: servicesProvider.settingsStorage.selectedRoleIndex)?.shortTitle)
        addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let lastIndex {
            mainView.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: animated)
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        navigationItem.title = "Chat screen"
    }
    
    private func setupModel() {
        do {
            model = try servicesProvider.coreDataManager.getAllChatMessages()
            mainView.tableView.reloadData()
        } catch {
            print(error)
        }
    }
}

// MARK: - ChatScreenViewDelegate

extension ChatScreenViewController: ChatScreenViewDelegate {
    func sendButtonDidTap(text: String?) {
        guard let message = text else { return }
        let messageModel = MessageModel(isFromUser: true, message: message, timestamp: Date())
        do {
            try servicesProvider.coreDataManager.saveChatMessage(messageModel)
            model.append(messageModel)
            guard let lastIndex else { return }
            let tableView = mainView.tableView
            tableView.performBatchUpdates({ tableView.insertRows(at: [lastIndex], with: .bottom) })
            tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
            mainView.resetInput()
            mainView.setSendButtonEnabled(isEnabled: false)
        } catch {
            print(error)
        }
    }
    
    func messageTextFieldChanged(text: String?) {
        guard let text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            mainView.setSendButtonEnabled(isEnabled: false)
            return
        }
        mainView.setSendButtonEnabled(isEnabled: true)
    }
    
    func roleIndicatorDidTap() {
        performSegue(withIdentifier: "goToChatRoleScreen", sender: nil)
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

// MARK: - Keyboard

private extension ChatScreenViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        guard let animationInf = notification.keyboardAnimationInfo else { return }
        mainView.animateKeyboardHeightChange(
            to: animationInf.height,
            with: animationInf.duration,
            options: animationInf.options
        ) { [weak self] in
            guard let self, let lastIndex else { return }
            self.mainView.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
        }
    }
    
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        guard let animationInf = notification.keyboardAnimationInfo else { return }
        mainView.animateKeyboardHeightChange(
            to: 0.0,
            with: animationInf.duration,
            options: animationInf.options
        )
    }
}
