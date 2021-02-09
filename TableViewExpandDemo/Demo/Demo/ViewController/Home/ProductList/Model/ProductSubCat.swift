//
//  ProductSubCat.swift
//  Demo
//
//  Created by Vivek Purohit on 09/02/21.
//

import UIKit

class ProductSubCat: NSObject {
    var id: Int
    var name: String
    var c_id: Int
    var products: [ProductObj]
    var isSelected = false
    
    init(withID id: Int, andName name: String, andCatId c_id: Int, andProduct products: [ProductObj], isSelected: Bool = false) {
        self.id = id
        self.name = name
        self.c_id = c_id
        self.products = products
        self.isSelected = isSelected
    }
}
