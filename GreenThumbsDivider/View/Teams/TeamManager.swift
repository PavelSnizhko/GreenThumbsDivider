//
//  TeamManager.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 10.06.2023.
//

import CoreData
import Foundation

protocol TeamManagement {
    func createTeam(teamName: String, players: [Player])
    func fetchTeams() -> [Team]
    func deleteTeam(team: Team)
    func deleteAllTeams()
}

final class TeamManager: TeamManagement {
    let managedObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    func createTeam(teamName: String, players: [Player]) {
        let team = Team(context: managedObjectContext)
        team.name = teamName
        // Assuming Member is another Core Data entity related to Team, you would need to handle the relationship appropriately
        team.players = NSSet(array: players)
//        team.relationship = NSSet(array: members) // Assuming the relationship is a to-many relationship
        
        do {
            try managedObjectContext.save()
        } catch {
            // Handle the error gracefully
            print("Failed to save team: \(error)")
        }
    }
    
    func fetchTeams() -> [Team] {
        let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
        
        do {
            let teams = try managedObjectContext.fetch(fetchRequest)
            return teams
        } catch {
            // Handle the error gracefully
            print("Failed to fetch teams: \(error)")
            return []
        }
    }
    
    func deleteTeam(team: Team) {
        managedObjectContext.delete(team)
        
        do {
            try managedObjectContext.save()
        } catch {
            // Handle the error gracefully
            print("Failed to delete team: \(error)")
        }
    }
    
    func deleteAllTeams() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Team.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch {
            // Handle the error gracefully
            print("Failed to delete all teams: \(error)")
        }
    }
}
