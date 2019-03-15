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

class ConversationTableViewMessageItem: CellViewModelSizable {
    var message: Message?
    func height() -> CGFloat {
        return 130
    }
}

protocol ConversationTableViewModelDelegate: class {
    func conversationTableViewModel(_ viewModel: ConversationTableViewModel, didChangeData data: [[ViewModel]])
}

public class ConversationTableViewModel: ViewModel {
    weak var delegate: ConversationTableViewModelDelegate?
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
            delegate?.conversationTableViewModel(self, didChangeData: cellViewModels)
        }
    }
    
    init(pseudo: Pseudo) {
        self.pseudo = pseudo
    }
    
    func loadData() {
//        latestMessagesResource = MojnAPI.sharedInstance.latestMessages(from: pseudo.phoneNumber)
        latestMessagesResource = MojnAPI.sharedInstance.numbers()
    }
}

extension ConversationTableViewModel: ResourceObserver {
    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {
//        print(resource.typedContent()!)
//        guard let messages: [Message] = resource.typedContent() else { return }
//
//        let data = messages.map { (message) -> ConversationTableViewMessageItem in
//            let vm = ConversationTableViewMessageItem()
//            vm.message = message
//
//            return vm
//        }
//
//        self.cellViewModels = [data]
    }
}
