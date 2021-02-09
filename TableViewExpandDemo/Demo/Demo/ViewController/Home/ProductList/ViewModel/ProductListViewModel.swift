//
//  ProductListViewModel.swift
//  Demo
//
//  Created by Vivek Purohit on 09/02/21.
//

import UIKit

class ProductListViewModel: NSObject {

    public static let shared = ProductListViewModel()
}
//MARK:- Public Functions
extension ProductListViewModel {
    func getDatasource() -> [ProductCat] {
        var datasource = [ProductCat]()
        let categories = CoreDataHelper.shared.fetchDataFromCategory()
        for cat in categories {
            datasource.append(ProductCat(withID: (cat.value(forKeyPath: CoreKeys.id.rawValue) as? Int ?? 0), andName: (cat.value(forKeyPath: CoreKeys.name.rawValue) as? String ?? ""), andSubCat: getSubCat(forCatId: (cat.value(forKeyPath: CoreKeys.id.rawValue) as? Int ?? 0))))
        }
        return datasource
    }
    
    func getSubCat(forCatId: Int) -> [ProductSubCat] {
        var datasource = [ProductSubCat]()
        let categories = CoreDataHelper.shared.fetchDataFromSubCategory(withRootId: forCatId)
        for cat in categories {
            datasource.append(ProductSubCat(withID: (cat.value(forKeyPath: CoreKeys.id.rawValue) as? Int ?? 0), andName: (cat.value(forKeyPath: CoreKeys.name.rawValue) as? String ?? ""), andCatId: (cat.value(forKeyPath: CoreKeys.c_id.rawValue) as? Int ?? 0), andProduct: getProducts(forSubCatId: (cat.value(forKeyPath: CoreKeys.id.rawValue) as? Int ?? 0))))
        }
        return datasource
    }
    
    func getProducts(forSubCatId: Int) -> [ProductObj] {
        var datasource = [ProductObj]()
        let categories = CoreDataHelper.shared.fetchDataFromProduct(withSubCatId: forSubCatId)
        for cat in categories {
            datasource.append(ProductObj(withID: (cat.value(forKeyPath: CoreKeys.id.rawValue) as? Int ?? 0), andName: (cat.value(forKeyPath: CoreKeys.name.rawValue) as? String ?? ""), andSubCatId: (cat.value(forKeyPath: CoreKeys.s_id.rawValue) as? Int ?? 0)))
        }
        return datasource
    }
}
