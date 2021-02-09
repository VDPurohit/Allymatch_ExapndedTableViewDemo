//
//  CoreDataHelper.swift
//  Demo
//
//  Created by Vivek Purohit on 09/02/21.
//

import UIKit
import CoreData

enum CoreTables: String {
    case category = "Category"
    case subCategory = "SubCategory"
    case product = "Product"
}

enum CoreKeys: String {
    case id = "id"
    case name = "name"
    case c_id = "c_id"
    case s_id = "s_id"
}

class CoreDataHelper: NSObject {
    public static let shared = CoreDataHelper()
}
//MARK:- Public Function
extension CoreDataHelper {
    func saveCategory(name: String) {
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: CoreTables.category.rawValue, in: managedContext)!
        
        let product = NSManagedObject(entity: entity, insertInto: managedContext)
       
        product.setValue(self.fetchDataFromCategory().count, forKey: CoreKeys.id.rawValue)
        product.setValue(name, forKeyPath: CoreKeys.name.rawValue)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveSubCategory(name: String, for categoryId: Int) {
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: CoreTables.subCategory.rawValue, in: managedContext)!
        
        let product = NSManagedObject(entity: entity, insertInto: managedContext)
       
        product.setValue(self.fetchDataFromSubCategory().count, forKey: CoreKeys.id.rawValue)
        product.setValue(name, forKeyPath: CoreKeys.name.rawValue)
        product.setValue(categoryId, forKeyPath: CoreKeys.c_id.rawValue)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveProduct(name: String, for subCategoryId: Int) {
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: CoreTables.product.rawValue, in: managedContext)!
        
        let product = NSManagedObject(entity: entity, insertInto: managedContext)
       
        product.setValue(self.fetchDataFromProduct().count, forKey: CoreKeys.id.rawValue)
        product.setValue(name, forKeyPath: CoreKeys.name.rawValue)
        product.setValue(subCategoryId, forKeyPath: CoreKeys.s_id.rawValue)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchDataFromCategory() -> [NSManagedObject] {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: CoreTables.category.rawValue)
        
        do {
            let products = try managedContext.fetch(fetchRequest)
            return products
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func fetchDataFromSubCategory(withRootId: Int? = nil) -> [NSManagedObject] {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: CoreTables.subCategory.rawValue)
        if withRootId != nil {
            fetchRequest.predicate = NSPredicate(format: "c_id == %d", withRootId!)
        }
        
        do {
            let products = try managedContext.fetch(fetchRequest)
            return products
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func fetchDataFromProduct(withSubCatId: Int? = nil) -> [NSManagedObject] {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: CoreTables.product.rawValue)
        if withSubCatId != nil {
            fetchRequest.predicate = NSPredicate(format: "s_id == %d", withSubCatId!)
        }
        
        do {
            let products = try managedContext.fetch(fetchRequest)
            return products
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
