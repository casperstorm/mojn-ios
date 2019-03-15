//
//  Keychain.swift
//  mojn
//
//  Created by Casper Rogild Storm on 14/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Valet

enum ValetIdentifiers: String {
    case credentials = "mojn.valet.identifier.credentials"
}

enum ValetKeys: String {
    case sid    = "mojn.valet.key.sid"
    case token  = "mojn.valet.key.token"
}

class Keychain {
    let valet: Valet
    
    init(identifier: ValetIdentifiers) {
        self.valet = Valet.valet(with: Identifier(nonEmpty: identifier.rawValue)!, accessibility: .whenUnlocked)
    }
    
    func set(_ value: String, key: ValetKeys) {
        valet.set(string: value, forKey: key.rawValue)
    }
    
    func get(_ key: ValetKeys) -> String? {
        return valet.string(forKey: key.rawValue)
    }
}
