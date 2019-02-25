//
//  Pseudo.swift
//  mojn
//
//  Created by Casper Rogild Storm on 25/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

struct Pseudo: Codable {
    let id, firstName, lastName, description, phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case description
        case phoneNumber
    }
}
