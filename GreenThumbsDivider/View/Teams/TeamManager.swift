//
//  TeamManager.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 10.06.2023.
//

import CoreData
import Combine
import UIKit

protocol TeamManagement {
    func createTeam(teamName: String, players: [PlayerEntity])
    func fetchTeams() -> [TeamModel]
    func deleteTeam(team: TeamEntity)
    func deleteAllTeams()
}

final class TeamStorage: NSObject, ObservableObject {
    
    static let shared = TeamStorage()
    
    var teams = CurrentValueSubject<[TeamModel], Never>([])
    private let teamFetchController: NSFetchedResultsController<TeamEntity>
    private let managedObjectContext = PersistenceController.shared.container.viewContext
    
    private override init() {
        let sortDescription = [NSSortDescriptor(key: "name", ascending: true)]
        let featchRequest = TeamEntity.fetchRequest()
        featchRequest.sortDescriptors = sortDescription
        self.teamFetchController = NSFetchedResultsController(fetchRequest: featchRequest,
                                                              managedObjectContext: PersistenceController.shared.container.viewContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        super.init()
        
        teamFetchController.delegate = self
        do {
            try teamFetchController.performFetch()
            teams.value = mapToTeamModels(from: teamFetchController.fetchedObjects ?? [])
        } catch {
            NSLog("Error: could not fetch objects")
        }
    }
    
    private func mapToTeamModels(from teamEntities: [TeamEntity]) -> [TeamModel] {
        teamEntities.compactMap { teamEntity -> TeamModel? in
            let players = teamEntity.playerModels
            guard let id = teamEntity.id,
                  let name = teamEntity.name  else {
                return nil
            }
            
            if let iconData = teamEntity.icon {
                return TeamModel(id: id, name: name, icon:  UIImage(data: iconData) ?? UIImage(named: "Barcelona")!, players: players)
            }
            
            return TeamModel(id: id, name: name, icon: UIImage(named: "Barcelona")!, players: players)
        }
    }
    
    func createTeam(teamName: String, players: [PlayerEntity]) {
        let team = TeamEntity(context: teamFetchController.managedObjectContext)
        team.id = UUID()
        team.name = teamName
        team.players = NSSet(array: players)
        saveContext()
    }

    func update() {
        // TODO: if it's needed then I'll add it
    }

    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest(withUUID: id)
        
        do {
            guard let team = try managedObjectContext.fetch(fetchRequest).first else {
                return
            }
            managedObjectContext.delete(team)
            saveContext()
        } catch {
            print("Failed to delete team: \(error)")
        }        
    }
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            // Handle the error gracefully
            print("Failed to save team: \(error)")
        }
    }
    
}

extension TeamStorage: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let teams = controller.fetchedObjects as? [TeamEntity] else { return }
        print("Context has changed, reloading courses")
        let teamModels = teams.map { teamEntity in
            TeamModel(id: UUID(), name: teamEntity.name ?? "", icon: UIImage(named: "Barcelona")!, players: teamEntity.playerModels)
        }
        
        self.teams.value = teamModels
    }
}
