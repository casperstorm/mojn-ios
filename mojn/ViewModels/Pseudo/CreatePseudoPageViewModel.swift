//
//  CreatePseudoPageViewModel.swift
//  mojn
//
//  Created by Casper Rogild Storm on 22/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Siesta
import UIKit

class CreatePseudoPageViewModel: ViewModel {
    let builder: PseudoBuilder = PseudoBuilder()

    func pseudoPhoneNumber(number: Number) {
        builder.withPhoneNumber(number.number)
    }
    
    func pseudoTitle(title: String) {
        builder.withTitle(title)
    }
    
    func pseudoName(name: String) {
        builder.withName(name)
    }
    
    func pseudoEmoji(emoji: String) {
        builder.withEmoji(emoji)
    }
    
    func build() -> Pseudo {
        return builder.build()
    }
}
