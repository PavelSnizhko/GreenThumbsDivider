//
//  Member+CoreDataProperties.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 12.06.2023.
//
//

import Foundation
import CoreData


extension Member {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member> {
        return NSFetchRequest<Member>(entityName: "Member")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var talent: Int16

}

extension Member : Identifiable {

}
