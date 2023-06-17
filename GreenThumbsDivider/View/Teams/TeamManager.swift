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
    func createTeam(teamName: String, players: [Player])
    func fetchTeams() -> [TeamModel]
    func deleteTeam(team: Team)
    func deleteAllTeams()
}

final class TeamStorage: NSObject, ObservableObject {
    
    static let shared = TeamStorage()
    
    var teams = CurrentValueSubject<[TeamModel], Never>([])
    private let teamFetchController: NSFetchedResultsController<Team>
    private let managedObjectContext = PersistenceController.shared.container.viewContext
    
    private override init() {
        let sortDescription = [NSSortDescriptor(key: "name", ascending: true)]
        let featchRequest = Team.fetchRequest()
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
    
    private func mapToTeamModels(from teamEntities: [Team]) -> [TeamModel] {
        teamEntities.map { teamEntity in
            TeamModel(id: UUID(), name: teamEntity.name ?? "", icon: UIImage(named: "Barcelona")!, players: teamEntity.playerModels)
        }
    }
    
    func createTeam(teamName: String, players: [Player]) {
        let team = Team(context: teamFetchController.managedObjectContext)
        team.name = teamName
        team.players = NSSet(array: players)
    
        do {
            try managedObjectContext.save()
        } catch {
            // Handle the error gracefully
            print("Failed to save team: \(error)")
        }
    }

    func update() {
        // TODO: if it's needed then I'll add it
    }

    func delete(id: UUID) {
        //TODO: make after changing core data models
    }
    
}

extension TeamStorage: NSFetchedResultsControllerDelegate {
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let teams = controller.fetchedObjects as? [Team] else { return }
        print("Context has changed, reloading courses")
        let teamModels = teams.map { teamEntity in
            TeamModel(id: UUID(), name: teamEntity.name ?? "", icon: UIImage(named: "Barcelona")!, players: teamEntity.playerModels)
        }
        
        self.teams.value = teamModels
    }
}
