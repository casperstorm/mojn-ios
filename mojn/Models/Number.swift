//
//  Number.swift
//  mojn
//
//  Created by Casper Rogild Storm on 14/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct Number: Codable {
    let number: String
    
    enum CodingKeys: String, CodingKey {
        case number
    }
    
    private init(number: String) {
        self.number = number
    }
    
    init?(_ json: JSON) {
        guard let number = json["phone_number"].string else { return nil }
        self.init(number: number)
    }
    
}
