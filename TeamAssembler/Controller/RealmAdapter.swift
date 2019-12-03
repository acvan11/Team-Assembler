//
//  RealmAdapter.swift
//  TeamAssembler
//
//  Created by K Y on 11/26/19.
//  Copyright © 2019 Yu. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmAdapter {
    let realm = try! Realm()
    
    // MARK: - Reading from Realm
    // and convertion to native Array type.
    func fetchObjects<T: Object>(_ type: T.Type) -> [T] {
        return realm.objects(T.self).compactMap { $0 }
    }
    
    // MARK: - Writing to Realm
    
    func add(_ obj: Object) {
        try! realm.write {
            realm.add(obj)
        }
    }
    
    // MARK: - Deleting from Realm
    
    func delete(_ obj: Object) {
        try! realm.write {
            realm.delete(obj)
        }
    }
}
