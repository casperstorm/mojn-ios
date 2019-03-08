//
//  PseudoCollectionViewCellConfigurator.swift
//  mojn
//
//  Created by Casper Rogild Storm on 06/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

class PseudoCollectionViewCellConfigurator {
    func configure(_ cell: PseudoAddCell, with viewModel: AddItemViewModel) {
    }
    
    func configure(_ cell: PseudoCountCell, with viewModel: CountItemViewModel) {
        let count = viewModel.count ?? 0
        cell.countLabel.text = "\(count)"
        cell.descriptionLabel.text = "Accounts"
    }
    
    func configure(_ cell: PseudoCell, with viewModel: PseudoItemViewModel) {
        cell.descriptionLabel.text = viewModel.description
        cell.nameLabel.text = viewModel.name()
        cell.phoneLabel.text = viewModel.phoneNumber
        cell.emojiLabel.text = viewModel.emoji
    }
    
    func configure(_ cell: PseudoHeaderCell, with viewModel: HeaderItemViewModel) {
    }
}
