//
//  Item.swift
//  TodoList
//
//  Created by Nyman Sikazwe on 5/20/19.
//  Copyright © 2019 Nyman Sikazwe. All rights reserved.
//

import Foundation
import RealmSwift


class Item: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    //Reverse relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
