//
//  SkillsModel+CoreDataProperties.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 12.06.2023.
//
//

import Foundation
import CoreData


extension SkillsModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SkillsModel> {
        return NSFetchRequest<SkillsModel>(entityName: "SkillsModel")
    }

    @NSManaged public var skillsData: Data?
    
    var skills: Skills? {
        get {
            guard let skillsData = skillsData else { return nil }
            return try? JSONDecoder().decode(Skills.self, from: skillsData)
        }
        set {
            if let newValue = newValue {
                skillsData = try? JSONEncoder().encode(newValue)
            } else {
                skillsData = nil
            }
        }
    }

}

extension SkillsModel : Identifiable {

}
