//
//  PlayerManager.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 12.06.2023.
//

import CoreData
import UIKit

class PlayerManager: ObservableObject {
    private let context: NSManagedObjectContext
    private var players: [PlayerEntity] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    
    func addPlayer(_ player: PlayerModel) {
        
        let newPlayer = PlayerEntity(context: context)
        newPlayer.id = player.id
        newPlayer.firstName = player.name
        newPlayer.lastName = player.nickName
        newPlayer.clubIcon = player.club?.pngData()
        newPlayer.countryIcon = player.country.pngData()
        newPlayer.image = player.image?.pngData()
        newPlayer.isGoalkeeper = player.isGoalkeeper
        newPlayer.position = player.playerPosition
        newPlayer.allSkills = player.skills
        
        saveContext()
    }
    
    func createPlayer(firstName: String,
                      lastName: String,
                      position: Position,
                      isGoalkeeper: Bool,
                      image: UIImage?,
                      clubIcon: UIImage?,
                      countryIcon: UIImage?,
                      skills: [Skills]) {
        
        let newPlayer = PlayerEntity(context: context)
        newPlayer.id = UUID()
        newPlayer.firstName = firstName
        newPlayer.lastName = lastName
        newPlayer.position = position
        newPlayer.isGoalkeeper = isGoalkeeper
        newPlayer.image = image?.jpegData(compressionQuality: 1)
        newPlayer.clubIcon = clubIcon?.jpegData(compressionQuality: 1)
        newPlayer.countryIcon = countryIcon?.jpegData(compressionQuality: 1)
        newPlayer.allSkills = skills
        
        saveContext()
    }
    
    func fetchPlayers() -> [PlayerEntity] {
        let fetchRequest: NSFetchRequest<PlayerEntity> = PlayerEntity.fetchRequest()
        
        do {
            
            let players = try context.fetch(fetchRequest)
            self.players = players
            return players
        } catch {
            print("Error fetching players: \(error)")
            return []
        }
    }
    
    func updatePlayer(_ player: PlayerEntity,
                      firstName: String,
                      lastName: String,
                      position: Position,
                      isGoalkeeper: Bool,
                      image: UIImage?,
                      clubIcon: UIImage?,
                      countryIcon: UIImage?,
                      skills: [Skills]) {
        
        player.firstName = firstName
        player.lastName = lastName
        player.position = position
        player.isGoalkeeper = isGoalkeeper
        player.image = image?.jpegData(compressionQuality: 1)
        player.clubIcon = clubIcon?.jpegData(compressionQuality: 1)
        player.countryIcon = countryIcon?.jpegData(compressionQuality: 1)
        player.allSkills = skills

        saveContext()
    }
    
    func deletePlayer(_ player: PlayerEntity) {
        context.delete(player)
        
        saveContext()
    }
    
    func deletePlayer(by id: UUID) {
        guard let playerToDelete = players.first(where: { $0.id == id }) else {
            return
        }
        
        context.delete(playerToDelete)
        players.removeAll(where: { $0 == playerToDelete })
        
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

extension PlayerEntity {
    func mapToModel() -> PlayerModel? {
        guard let id,
              let firstName,
              let lastName,
              let iconData = self.countryIcon,
              let countryIcon = UIImage(data: iconData),
              let imageData = self.image,
              let clubIconData = self.clubIcon else {
            return nil
        }
                
        guard let accountImage = UIImage(data: imageData) else {
            return nil
        }
        
        let fixedOrientationAccountImage = accountImage.fixOrientation()
        let fixedOrientationClubImage = UIImage(data: clubIconData)?.fixOrientation()
        let fixedOrientationCountryImage = countryIcon.fixOrientation()
        
        return PlayerModel(id: id,
                           name: firstName,
                           nickName: lastName,
                           image: fixedOrientationAccountImage,
                           club: fixedOrientationClubImage,
                           country: fixedOrientationCountryImage,
                           skills: self.allSkills,
                           playerPosition: self.position)
    }
}
