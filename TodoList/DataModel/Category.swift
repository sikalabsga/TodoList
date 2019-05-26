//
//  Category.swift
//  TodoList
//
//  Created by Nyman Sikazwe on 5/20/19.
//  Copyright © 2019 Nyman Sikazwe. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    //forward relationship
    let items = List<Item>()
}

