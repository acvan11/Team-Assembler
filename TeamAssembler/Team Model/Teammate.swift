//
//  Teammate.swift
//  TeamAssembler
//
//  Created by K Y on 11/26/19.
//  Copyright © 2019 Yu. All rights reserved.
//

import Foundation
import RealmSwift

/*
 Remark: Realm requires a specific subclass and property type.
 However, there isn't any specific initializers for Realm, unlike, say, Core Data.
 */

class Teammate: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var might: String = ""
    
    convenience init(name: String, might: String) {
        self.init()
        self.name = name
        self.might = might
    }
    
}
