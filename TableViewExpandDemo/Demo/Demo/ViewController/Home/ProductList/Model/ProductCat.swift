//
//  ProductCat.swift
//  Demo
//
//  Created by Vivek Purohit on 09/02/21.
//

import UIKit

class ProductCat: NSObject {
    var id: Int
    var name: String
    var isSelected = false
    var subCat: [ProductSubCat]
    
    init(withID id: Int, andName name: String, andSubCat subCat: [ProductSubCat], isSelected: Bool = false) {
        self.id = id
        self.name = name
        self.subCat = subCat
        self.isSelected = isSelected
    }
}
