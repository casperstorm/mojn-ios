//
//  Pseudo.swift
//  mojn
//
//  Created by Casper Rogild Storm on 25/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//
import RealmSwift
import Foundation

class Pseudo: Object {
    @objc dynamic var name: String? = nil
    @objc dynamic var title: String? = nil
    @objc dynamic var phoneNumber: String? = nil
    @objc dynamic var emoji: String? = nil
}
