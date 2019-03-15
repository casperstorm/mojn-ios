//
//  Database.swift
//  mojn
//
//  Created by Casper Rogild Storm on 14/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Database {
    let realm: Realm
    
    init() {
      self.realm = try! Realm()
    }
    
    func queryPseudos() -> Results<Pseudo>? {
        return realm.objects(Pseudo.self)
    }
    
    func writePseudo(_ pseudo: Pseudo) {
        try! realm.write {
            realm.add(pseudo)
        }
    }
}
