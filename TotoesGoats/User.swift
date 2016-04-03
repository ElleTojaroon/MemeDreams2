//
//  User.swift
//  TotoesGoats
//
//  Created by Paviya Tojaroon on 4/3/16.
//  Copyright © 2016 Daniel Hauagge. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


func rand() -> Double
{
    return Double(arc4random()) / Double(UINT32_MAX)
}

class User : Object {
    dynamic var id = NSUUID().UUIDString
    dynamic var username = ""
    dynamic var password = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}