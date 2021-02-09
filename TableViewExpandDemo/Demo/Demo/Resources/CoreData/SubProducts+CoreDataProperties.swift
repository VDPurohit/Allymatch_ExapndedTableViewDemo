//
//  SubProducts+CoreDataProperties.swift
//  Demo
//
//  Created by Bhavik Barot on 09/02/21.
//
//

import Foundation
import CoreData


extension SubProducts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubProducts> {
        return NSFetchRequest<SubProducts>(entityName: "SubProducts")
    }

    @NSManaged public var id: Double
    @NSManaged public var productName: String?
    @NSManaged public var rootId: Double

}
