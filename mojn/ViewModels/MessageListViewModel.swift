//
//  MessageListViewModel.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

class MessageItemMessageListViewModel: CellViewModelSizable {
    func height() -> CGFloat {
        return 130
    }
}

protocol MessageListViewModelDelegate: class {
    func messageListViewModel(_ viewModel: MessageListViewModel, didChangeData data: [[ViewModel]])
}

public class MessageListViewModel: ViewModel {
    weak var delegate: MessageListViewModelDelegate?
    let pseudo: Pseudo
    var cellViewModels = [[ViewModel]]() {
        didSet {
            delegate?.messageListViewModel(self, didChangeData: cellViewModels)
        }
    }
    
    init(pseudo: Pseudo) {
        self.pseudo = pseudo
    }
}
