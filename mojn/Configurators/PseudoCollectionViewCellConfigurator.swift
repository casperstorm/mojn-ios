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
    func configure(_ cell: PseudoCollectionAddCell, with viewModel: PseudoCollectionAddCellViewModel) {
    }
    
    func configure(_ cell: PseudoCollectionCountCell, with viewModel: PseudoCollectionCountCellViewModel) {
        let count = viewModel.count ?? 0
        cell.countLabel.text = "\(count)"
        cell.descriptionLabel.text = "Accounts"
    }
    
    func configure(_ cell: PseudoCollectionDefaultCell, with viewModel: PseudoCollectionDefaultCellViewModel) {
        cell.descriptionLabel.text = viewModel.pseudo?.title
        cell.nameLabel.text = viewModel.name()
        cell.phoneLabel.text = viewModel.pseudo?.phoneNumber
        cell.emojiLabel.text = viewModel.pseudo?.emoji
    }
    
    func configure(_ cell: PseudoCollectionHeaderCell, with viewModel: PseudoCollectionHeaderCellViewModel) {
    }
    
    func configure(_ cell: PseudoCollectionEmptyCell, with viewModel: PseudoCollectionEmptyCellViewModel) {
    }
}
