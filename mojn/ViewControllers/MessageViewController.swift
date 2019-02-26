//
//  MessageViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 26/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import MessageKit

class MessageViewController: MessagesViewController {
    let mySender = Sender(id: "any_unique_id", displayName: "Steven")
    let otherSender = Sender(id: "any_unique_id_2", displayName: "Casper")
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Mojn du"
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        self.messages = [
            Message(text: "hello", sender: self.otherSender, messageId: "1", date: Date()),
            Message(text: "foo bar", sender: self.mySender, messageId: "2", date: Date()),
            Message(text: "foo bar", sender: self.otherSender, messageId: "3", date: Date()),
            Message(text: "foo bar", sender: self.mySender, messageId: "4", date: Date()),
        ]
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
