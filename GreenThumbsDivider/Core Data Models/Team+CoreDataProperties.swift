//
//  Team+CoreDataProperties.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 12.06.2023.
//
//

import Foundation
import CoreData


extension TeamEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamEntity> {
        return NSFetchRequest<TeamEntity>(entityName: "TeamEntity")
    }
    
    public class func fetchRequest(withUUID id: UUID) -> NSFetchRequest<TeamEntity> {
         let fetchTeam: NSFetchRequest<TeamEntity> = self.fetchRequest()
         fetchTeam.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
         return fetchTeam
     }
    
    @NSManaged public var id: UUID?
    @NSManaged public var icon: Data?
    @NSManaged public var name: String?
    @NSManaged public var players: NSSet?
    
    var playerModels: [PlayerModel] {
        guard let players = players as? Set<Player> else {
            return []
        }
        
        return players.compactMap { $0.mapToModel() }
    }
}

// MARK: Generated accessors for players
extension TeamEntity {
    
    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: Player)
    
    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: Player)
    
    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSSet)
    
    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSSet)
    
}

extension TeamEntity : Identifiable {
    
}
