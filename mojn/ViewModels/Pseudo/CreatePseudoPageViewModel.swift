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
    
    func build() -> Pseudo {
        return builder.build()
    }
}
