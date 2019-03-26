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
    var phoneNumber: String?
    var title: String?
    var name: String?
    var emoji: String?

    func build() -> Pseudo {
        return builder
            .withTitle(title)
            .withEmoji(emoji)
            .withName(name)
            .withPhoneNumber(phoneNumber)
            .build()
    }
}
