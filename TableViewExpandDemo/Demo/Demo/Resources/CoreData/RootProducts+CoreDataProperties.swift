//
//  RootProducts+CoreDataProperties.swift
//  Demo
//
//  Created by Bhavik Barot on 09/02/21.
//
//

import Foundation
import CoreData


extension RootProducts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RootProducts> {
        return NSFetchRequest<RootProducts>(entityName: "RootProducts")
    }

    @NSManaged public var id: Double
    @NSManaged public var productName: String?

}
