//
//  Item+CoreDataProperties.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 12.06.2023.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var timestamp: Date?

}

extension Item : Identifiable {

}
