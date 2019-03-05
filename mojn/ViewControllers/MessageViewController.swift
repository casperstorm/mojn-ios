//
//  MessageViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 26/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import MessageKit
import Siesta

class MessageViewController: MessagesViewController {
    let mySender = Sender(id: "any_unique_id", displayName: "Steven")
    let otherSender = Sender(id: "any_unique_id_2", displayName: "Casper")
    var messages: [Message] = []
    var messageResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            messageResource?
                .addObserver(self)
                .loadIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Mojn du"
        
        self.messageResource = MojnAPI.sharedInstance.message()
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
}

extension MessageViewController: MessagesDataSource {
    func currentSender() -> Sender {
        return self.mySender
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
}

extension MessageViewController: MessagesDisplayDelegate, MessagesLayoutDelegate {
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
}

extension MessageViewController: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let messages: [Message] = resource.typedContent() else { return }
        self.messages = messages
        messagesCollectionView.reloadData()
    }
}
