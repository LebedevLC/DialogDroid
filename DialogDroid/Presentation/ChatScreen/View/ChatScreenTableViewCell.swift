//
//  ChatScreenTableViewCell.swift
//  DialogDroid
//
//  Created by Сергей Чумовских  on 13.02.2024.
//

import Lottie
import UIKit

final class ChatScreenTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let backgroundCellView = UIView()
    private let avatarImageView = UIImageView(image: R.image.avatarImage())
    private let dateLabel = UILabel()
    private let messageLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var animatedLogo = {
        let view = LottieAnimationView()
        view.animation = .named("Animation3")
        view.loopMode = .loop
        view.alpha = 0
        return view
    }()
    
    private lazy var leftSideAvatarViewConstraint = {
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
    }()
    private lazy var rightSideAvatarViewConstraint = {
        avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
    }()
    
    private lazy var leftSideDateLabelConstraint = {
        dateLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 4)
    }()
    private lazy var rightSideDateLabelConstraint = {
        dateLabel.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: -4)
    }()
    
    private lazy var leftSideMessageLabelConstraint = {
        messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
    }()
    private lazy var rightSideMessageLabelConstraint = {
        messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [ leftSideAvatarViewConstraint,
          rightSideAvatarViewConstraint,
          leftSideDateLabelConstraint,
          rightSideDateLabelConstraint,
          leftSideMessageLabelConstraint,
          rightSideMessageLabelConstraint ].forEach({ $0.isActive = false })
        messageLabel.text = nil
        dateLabel.text = nil
        animatedLogo.pause()
        animatedLogo.alpha = 0
        avatarImageView.alpha = 1
        messageLabel.textAlignment = .left
    }
    
    // MARK: - Public Methods
    
    func configure(from model: MessageModel) {
        messageLabel.text = model.message
        messageLabel.textAlignment = model.isFromUser ? .right : .left
        NSLayoutConstraint.activate([
            model.isFromUser ? rightSideDateLabelConstraint : leftSideDateLabelConstraint,
            model.isFromUser ? rightSideAvatarViewConstraint : leftSideAvatarViewConstraint,
            model.isFromUser ? rightSideMessageLabelConstraint : leftSideMessageLabelConstraint
        ])
        
        dateLabel.text = model.timestamp.formatted(date: .omitted, time: .omitted)
        
        if !model.isFromUser {
            animatedLogo.play()
            animatedLogo.alpha = 1
            avatarImageView.alpha = 0
        } else {
            avatarImageView.alpha = 1
        }
        
        layoutIfNeeded()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = .clear
        
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.cornerCurve = .continuous
        avatarImageView.layer.masksToBounds = true
        
        backgroundCellView.layer.cornerRadius = 8
        backgroundCellView.layer.cornerCurve = .continuous
        backgroundCellView.layer.masksToBounds = true
        backgroundCellView.backgroundColor = .gray.withAlphaComponent(0.1)
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [backgroundCellView, avatarImageView, animatedLogo, dateLabel, messageLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        })
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            
            animatedLogo.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            animatedLogo.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            animatedLogo.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            animatedLogo.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            messageLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            
            dateLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            
            backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            backgroundCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            backgroundCellView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -4),
            backgroundCellView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 4)
        ])
    }
}
