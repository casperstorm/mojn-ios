//
//  MessageListTableViewCellConfigurator.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

class MessageListTableViewCellConfigurator {
    func configure(_ cell: MessageListDefaultCell, with viewModel: MessageItemMessageListViewModel) {
        cell.recipientLabel.text = "Isak Johannesson"
        cell.snippetLabel.text = "I saw your post on craigslist, and I was wondering if you are willing to trade it for something else? Maybe my horse. It's a really nice horse."
        cell.timeLabel.text = "12:24"
    }
}

