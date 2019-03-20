//
//  ConversationTableViewModel.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Siesta

class MessageViewEmptyItem: CellViewModelSizable {
    func height() -> CGFloat {
        return 130
    }
}

class MessageViewMessageItem: CellViewModelSizable {
    var message: Message?
    func height() -> CGFloat {
        return 130
    }
}

protocol MessageViewModelDelegate: class {
    func MessageViewModel(_ viewModel: MessageViewModel, didChangeData data: [[ViewModel]])
}

public class MessageViewModel: ViewModel {
    weak var delegate: MessageViewModelDelegate?
    let pseudo: Pseudo
    var latestMessagesResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            latestMessagesResource?
                .addObserver(self)
                .loadIfNeeded()
        }
    }
    var cellViewModels = [[ViewModel]]() {
        didSet {
            delegate?.MessageViewModel(self, didChangeData: cellViewModels)
        }
    }
    
    init(pseudo: Pseudo) {
        self.pseudo = pseudo
    }
    
    func loadData() {
        guard let number = pseudo.phoneNumber else { return }
        latestMessagesResource = MojnAPI.sharedInstance.messages(from: number)
    }
}

extension MessageViewModel: ResourceObserver {
    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let messages: [Message] = resource.typedContent() else { return }
        let data = messages
            .removingDuplicates{$0.recipient}
            .map{ (message) -> MessageViewMessageItem in
            let vm = MessageViewMessageItem()
            vm.message = message

            return vm
        }

        self.cellViewModels = [data, [MessageViewEmptyItem()]]
    }
}

