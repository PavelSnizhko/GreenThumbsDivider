//
//  Player+CoreDataProperties.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 12.06.2023.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var clubIcon: Data?
    @NSManaged public var countryIcon: Data?
    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var isGoalkeeper: Bool
    @NSManaged public var lastName: String?
    @NSManaged public var positionString: String?
    @NSManaged public var skills: NSSet?

    var position: Position {
        get {
            guard let positionString else {
                return .goalkeeper
            }
            return Position(rawValue: positionString) ?? .goalkeeper
        }
        
        set {
            positionString = newValue.rawValue
        }
    }
    
    var allSkills: [Skills] {
        get {
            guard let skills = skills as? Set<SkillsModel> else {
                return []
            }
            
            return skills.compactMap { $0.skills }
        }
        
        set {
            guard let context = self.managedObjectContext else {
                return
            }
            
            let skills = newValue.map { skill in
                let newSkill = SkillsModel(context: context)
                newSkill.skills = skill
                
                return newSkill
            }
            
            skills.forEach { skill in
                self.addToSkills(skill)
            }
        }
    }

}

// MARK: Generated accessors for skills
extension Player {

    @objc(addSkillsObject:)
    @NSManaged public func addToSkills(_ value: SkillsModel)

    @objc(removeSkillsObject:)
    @NSManaged public func removeFromSkills(_ value: SkillsModel)

    @objc(addSkills:)
    @NSManaged public func addToSkills(_ values: NSSet)

    @objc(removeSkills:)
    @NSManaged public func removeFromSkills(_ values: NSSet)

}

extension Player : Identifiable {

}
