//
//  PseudoBuilder.swift
//  mojn
//
//  Created by Casper Rogild Storm on 22/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation

class PseudoBuilder {
    private var name: String?
    private var title: String?
    private var phoneNumber: String?
    private var emoji: String?
    
    @discardableResult
    func withName(_ name: String) -> PseudoBuilder {
        self.name = name
        return self
    }
    
    @discardableResult
    func withTitle(_ title: String) -> PseudoBuilder {
        self.title = title
        return self
    }
    
    @discardableResult
    func withPhoneNumber(_ phoneNumber: String) -> PseudoBuilder {
        self.phoneNumber = phoneNumber
        return self
    }
    
    @discardableResult
    func withEmoji(_ emoji: String) -> PseudoBuilder {
        self.emoji = emoji
        return self
    }
    
    func build() -> Pseudo {
        let pseudo = Pseudo()
        pseudo.emoji = emoji
        pseudo.name = name
        pseudo.phoneNumber = phoneNumber
        pseudo.title = title
        
        return pseudo
    }
}
