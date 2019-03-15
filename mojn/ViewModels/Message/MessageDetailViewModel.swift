//
//  MessageDetailViewModel.swift
//  mojn
//
//  Created by Casper Rogild Storm on 15/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import MessageKit
import Siesta

protocol MessageDetailViewModelDelegate: class {
    func messageDetailViewModelDelegate(_ viewModel: MessageDetailViewModel, didChangeData data: [Message])
}

public class MessageDetailViewModel: ViewModel {
    weak var delegate: MessageDetailViewModelDelegate?
    var messages = [Message]() {
        didSet {
            delegate?.messageDetailViewModelDelegate(self, didChangeData: messages)
        }
    }
    let pseudo: Pseudo
    let recipient: String
    let sender: Sender
    
    var messagesResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            messagesResource?
                .addObserver(self)
                .loadIfNeeded()
        }
    }
    
    init(pseudo: Pseudo, recipient: String) {
        self.pseudo = pseudo
        self.recipient = recipient
        
        sender = Sender(id: pseudo.phoneNumber!, displayName: pseudo.phoneNumber!)
    }
}

extension MessageDetailViewModel {
    func loadData() {
        messagesResource = MojnAPI.sharedInstance.messages()
    }
}

extension MessageDetailViewModel: ResourceObserver {
    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let messages: [Message] = resource.typedContent() else { return }
        guard let sender = pseudo.phoneNumber else { return }
        
        
        self.messages = messages.filter({ (message) -> Bool in
            return message.recipient == sender || message.recipient == recipient
        })
    }
}
