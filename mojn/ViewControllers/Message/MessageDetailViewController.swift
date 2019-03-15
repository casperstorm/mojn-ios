//
//  MessageViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 26/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import MessageKit

class MessageDetailViewController: MessageKit.MessagesViewController {
    let viewModel: MessageDetailViewModel
    
    required public init(viewModel: MessageDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.recipient
        self.viewModel.delegate = self
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.backgroundColor = UIColor(hexString: "#310c4d")
        
        viewModel.loadData()
    }
}

extension MessageDetailViewController: MessagesDataSource {
    func currentSender() -> Sender {
        return viewModel.sender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return viewModel.messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return viewModel.messages[indexPath.section]
    }
}

extension MessageDetailViewController: MessagesDisplayDelegate, MessagesLayoutDelegate {
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        if message.sender == viewModel.sender {
            return UIColor(hexString: "#f98b74")
        } else {
            return UIColor.white
        }
    }
}


extension MessageDetailViewController: MessageDetailViewModelDelegate {
    func messageDetailViewModelDelegate(_ viewModel: MessageDetailViewModel, didChangeData data: [Message]) {
        messagesCollectionView.reloadData()
    }
}
