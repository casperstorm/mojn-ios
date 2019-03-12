//
//  ConversationTableViewModel.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

class ConversationTableViewMessageItem: CellViewModelSizable {
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
    var cellViewModels = [[ViewModel]]() {
        didSet {
            delegate?.conversationTableViewModel(self, didChangeData: cellViewModels)
        }
    }
    
    init(pseudo: Pseudo) {
        self.pseudo = pseudo
    }
}
