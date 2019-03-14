//
//  MessageListTableViewCellConfigurator.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

class ConversationTableViewCellConfigurator {
    func configure(_ cell: ConversationTableDefaultCell, with viewModel: ConversationTableViewMessageItem) {
        
        guard let message = viewModel.message else { return }
        guard case .text(let text) = message.kind else { return }
        
        cell.recipientLabel.text = message.recipient
        cell.snippetLabel.text = text
        
        cell.timeLabel.text = message.prettyDate()
    }
}

