//
//  NumberViewCellConfigurator.swift
//  mojn
//
//  Created by Casper Rogild Storm on 20/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

class NumberViewCellConfigurator {
    func configure(_ cell: NumberDefaultCell, with viewModel: NumberDefaultCellViewModel) {
        cell.numberLabel.text = viewModel.number?.number
        
        if let pseudo = viewModel.pseudo {
            guard let title = pseudo.title else { return }
            cell.pseudoLabel.text = "Currently used in your \"\(title)\" pseudo"
        }
    }
}
