//
//  User.swift
//  mojn
//
//  Created by Casper Rogild Storm on 21/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

struct User: Codable {
    let id, username: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
    }
}
