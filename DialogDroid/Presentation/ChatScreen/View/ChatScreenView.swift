//
//  ChatScreenView.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 16.02.2024.
//

import UIKit

protocol ChatScreenViewDelegate: AnyObject {
    func sendButtonDidTap(text: String?)
    func messageTextFieldChanged(text: String?)
    func roleIndicatorDidTap()
}

final class ChatScreenView: UIView {
    
    // MARK: - Public Properties
    
    weak var delegate: ChatScreenViewDelegate?
    
    // MARK: - Private Properties
    
    private(set) lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(ChatScreenTableViewCell.self, forCellReuseIdentifier: "ChatScreenTableViewCell")
        tableview.showsVerticalScrollIndicator = false
        tableview.backgroundColor = .clear
        tableview.separatorStyle = .none
        tableview.keyboardDismissMode = .onDrag
        tableview.allowsSelection = false
        return tableview
    }()
    
    private let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let falseInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(messageTextFieldEditingChanged), for: .editingChanged)
        textField.placeholder = R.string.localizable.chatScreenPlaceholder()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(sendButtonDidTap), for: .touchUpInside)
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.imageView?.tintColor = .black
        button.backgroundColor = . white
        button.isEnabled = false
        return button
    }()
    
    private lazy var roleIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        view.layer.borderWidth = 1
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(roleIndicatorViewDidTap)))
        return view
    }()
    
    private let roleIndicatorLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private lazy var inputContainerViewBottomConstraint = {
        inputContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sendButton.layer.cornerRadius = sendButton.frame.width / 2
        roleIndicatorView.layer.cornerRadius = roleIndicatorView.frame.height / 2
        sendButton.layer.shadowPath = UIBezierPath(
            roundedRect: sendButton.bounds, cornerRadius: sendButton.layer.cornerRadius
        ).cgPath
        messageTextField.layer.shadowPath = UIBezierPath(
            roundedRect: messageTextField.bounds, cornerRadius: messageTextField.layer.cornerRadius
        ).cgPath
        inputContainerView.layer.shadowPath = UIBezierPath(rect: inputContainerView.bounds).cgPath
    }
    
    // MARK: - Public Methods
    
    func resetInput() {
        messageTextField.text = nil
    }
    
    func setSendButtonEnabled(isEnabled: Bool) {
        sendButton.isEnabled = isEnabled
    }
    
    func animateKeyboardHeightChange(
        to keyboardHeight: CGFloat,
        with duration: TimeInterval,
        options: UIView.AnimationOptions,
        completion: (() -> Void)? = nil
    ) {
        layoutIfNeeded()
        
        let height = keyboardHeight - (keyboardHeight > 0 ? safeAreaInsets.bottom : 0)
        inputContainerViewBottomConstraint.constant = -height
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: options,
            animations: {
                self.layoutIfNeeded()
            },
            completion: { finished in
                guard finished else { return }
                completion?()
            }
        )
    }
    
    func setRoleTitle(_ title: String?) {
        roleIndicatorLabel.text = title
    }
    
    // MARK: - Actions
    
    @objc private func sendButtonDidTap() {
        delegate?.sendButtonDidTap(text: messageTextField.text)
    }
    
    @objc private func messageTextFieldEditingChanged() {
        delegate?.messageTextFieldChanged(text: messageTextField.text)
    }
    
    @objc private func roleIndicatorViewDidTap() {
        delegate?.roleIndicatorDidTap()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubviews()
        configureView()
        setupLayout()
    }
    
    private func addSubviews() {
        [
            tableView,
            roleIndicatorView,
            roleIndicatorLabel,
            inputContainerView,
            falseInputContainerView,
            messageTextField,
            sendButton
        ].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }
    
    private func configureView() {
        let shadowOpacity: Float = 12.0
        let shadowRadius = 12.0
        let color = UIColor.black.withAlphaComponent(0.2).cgColor
        
        [sendButton, messageTextField, inputContainerView].forEach { view in
            let layer = view.layer
            layer.masksToBounds = false
            layer.shadowColor = color
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
        sendButton.layer.shadowOffset = .zero
        messageTextField.layer.shadowOffset = .zero
        inputContainerView.layer.shadowOffset = CGSize(width: 0, height: -4)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            inputContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputContainerView.heightAnchor.constraint(equalToConstant: 100),
            inputContainerViewBottomConstraint,
            
            falseInputContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            falseInputContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            falseInputContainerView.heightAnchor.constraint(equalToConstant: 100),
            falseInputContainerView.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -24),
            sendButton.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 24),
            sendButton.widthAnchor.constraint(equalToConstant: 44),
            sendButton.heightAnchor.constraint(equalToConstant: 44),
            
            messageTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 24),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -16),
            messageTextField.centerYAnchor.constraint(equalTo: sendButton.centerYAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 36),
            
            roleIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            roleIndicatorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            roleIndicatorView.heightAnchor.constraint(equalToConstant: 36),
            roleIndicatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            roleIndicatorLabel.leadingAnchor.constraint(equalTo: roleIndicatorView.leadingAnchor, constant: 4),
            roleIndicatorLabel.trailingAnchor.constraint(equalTo: roleIndicatorView.trailingAnchor, constant: -4),
            roleIndicatorLabel.centerYAnchor.constraint(equalTo: roleIndicatorView.centerYAnchor)
        ])
    }
}
