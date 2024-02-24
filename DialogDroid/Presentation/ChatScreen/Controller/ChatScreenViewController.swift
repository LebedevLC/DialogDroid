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
        navigationItem.title = R.string.localizable.chatScreenTitle()
    }
    
    private func setupModel() {
        do {
            model = try servicesProvider.coreDataManager.getAllChatMessages()
            mainView.tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    private func sendMessage() {
        servicesProvider.aiManager.getDialogueResponse(
            model,
            role: ChatRole(rawValue: servicesProvider.settingsStorage.selectedRoleIndex) ?? .dialog
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let text):
                DispatchQueue.main.async {
                    let newMessage = MessageModel(isFromUser: false, message: text, timestamp: Date())
                    self.saveMessage(newMessage)
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    let text = "Dialogue fail = \(failure.localizedDescription)"
                    let newMessage = MessageModel(isFromUser: false, message: text, timestamp: Date())
                    self.saveMessage(newMessage)
                }
            }
        }
    }
    
    private func saveMessage(_ message: MessageModel) {
        do {
            model.append(message)
            try servicesProvider.coreDataManager.saveChatMessage(message)
            addMessageToTable()
        } catch {
            print(error)
        }
    }
    
    private func addMessageToTable() {
        guard let lastIndex else { return }
        let tableView = mainView.tableView
        tableView.beginUpdates()
        tableView.insertRows(at: [lastIndex], with: .fade)
        tableView.endUpdates()
        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
}

// MARK: - ChatScreenViewDelegate

extension ChatScreenViewController: ChatScreenViewDelegate {
    func sendButtonDidTap(text: String?) {
        guard let message = text else { return }
        let messageModel = MessageModel(isFromUser: true, message: message, timestamp: Date())
        saveMessage(messageModel)
        mainView.resetInput()
        mainView.setSendButtonEnabled(isEnabled: false)
        sendMessage()
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
