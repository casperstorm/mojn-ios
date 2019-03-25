//
//  Seeds.swift
//  mojn
//
//  Created by Casper Rogild Storm on 14/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation

class Seeds {
    func generate() {
        let pseudo1 = Pseudo()
        pseudo1.emoji = "☀️"
        pseudo1.name = "Casper Storm"
        pseudo1.phoneNumber = "+447533003581"
        pseudo1.title = "Private"
        
        let pseudo2 = Pseudo()
        pseudo2.emoji = "🔥"
        pseudo2.name = "Bob Leo"
        pseudo2.phoneNumber = "+447533003582"
        pseudo2.title = "Tinder"


        let database = Database()
        database.writePseudo(pseudo1)
        database.writePseudo(pseudo2)
    }
}
