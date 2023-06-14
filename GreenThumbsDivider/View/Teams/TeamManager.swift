//
//  TeamManager.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 10.06.2023.
//

import CoreData
import UIKit

protocol TeamManagement {
    func createTeam(teamName: String, players: [Player])
    func fetchTeams() -> [TeamModel]
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
        team.players = NSSet(array: players)
        
        do {
            try managedObjectContext.save()
        } catch {
            // Handle the error gracefully
            print("Failed to save team: \(error)")
        }
    }
    
    func fetchTeams() -> [TeamModel] {
        let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
        
        do {
            let teams = try managedObjectContext.fetch(fetchRequest)
            let teamModels = teams.map { team in
                TeamModel(id: UUID(), name: team.name ?? "", icon: UIImage(named: "Barcelona")!, players: team.playerModels)
            }
            
            return teamModels
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
