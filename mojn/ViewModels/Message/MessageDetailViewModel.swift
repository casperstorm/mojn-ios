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
                .load()
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
    
    func sendMessage(text: String) {
        guard let sender = pseudo.phoneNumber else { return }
        let response = MojnAPI.sharedInstance.message(text: text, from: sender, to: recipient)
        response.onSuccess { [weak self] _ in
            self?.loadData()
        }
    }
}

extension MessageDetailViewModel: ResourceObserver {
    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let messages: [Message] = resource.typedContent() else { return }
        guard let sender = pseudo.phoneNumber else { return }

        let filtered = messages.filter({ (message) -> Bool in
            return message.recipient == sender || message.recipient == recipient
        }).sorted(by: { $0.sentDate.compare($1.sentDate) == .orderedAscending })
        
        self.messages = filtered
    }
}
