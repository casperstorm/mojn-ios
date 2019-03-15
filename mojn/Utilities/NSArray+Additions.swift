//
//  NSArray+Additions.swift
//  mojn
//
//  Created by Casper Rogild Storm on 15/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation

extension Array {
    func removingDuplicates<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}
