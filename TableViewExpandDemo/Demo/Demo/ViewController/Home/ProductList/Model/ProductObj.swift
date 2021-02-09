//
//  ProductObj.swift
//  Demo
//
//  Created by Vivek Purohit on 09/02/21.
//

import UIKit

class ProductObj: NSObject {
    var id: Int
    var name: String
    var s_id: Int
    var isSelected = false
    
    
    init(withID id: Int, andName name: String, andSubCatId s_id: Int, isSelected: Bool = false) {
        self.id = id
        self.name = name
        self.s_id = s_id
        self.isSelected = isSelected
    }
}
