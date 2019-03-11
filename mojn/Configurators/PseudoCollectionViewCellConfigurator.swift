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
    func configure(_ cell: PseudoAddCell, with viewModel: AddItemPseudosViewModel) {
    }
    
    func configure(_ cell: PseudoCountCell, with viewModel: CountItemPseudosViewModel) {
        let count = viewModel.count ?? 0
        cell.countLabel.text = "\(count)"
        cell.descriptionLabel.text = "Accounts"
    }
    
    func configure(_ cell: PseudoCell, with viewModel: PseudoItemPseudosViewModel) {
        cell.descriptionLabel.text = viewModel.pseudo?.description
        cell.nameLabel.text = viewModel.name()
        cell.phoneLabel.text = viewModel.pseudo?.phoneNumber
        cell.emojiLabel.text = viewModel.pseudo?.emoji
    }
    
    func configure(_ cell: PseudoHeaderCell, with viewModel: HeaderItemPseudosViewModel) {
    }
}
