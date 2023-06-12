//
//  CarouselViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 11.04.2023.
//

import SwiftUI
import CoreData

class PlayerViewModel: ObservableObject {
    @Published var members: [PlayerModel] = []
    @Published var memeberId: UUID?
    
    @Published var teams: Int = 2
    @Published var goalkeeper: Int = 1
    
    @Published var isAvailableSplitting: Bool = false
    
    private let playerManager: PlayerManager

    init(context: NSManagedObjectContext) {
        self.playerManager = PlayerManager(context: context)
    }
    
    
    var isPlaceholderVisisble: Bool {
        members.count == 0
    }
    
    func isAvailableSplitting(for members: [PlayerModel]) {
        if members.count > 3 || (members.count == 3 && goalkeeper == 1) {
            isAvailableSplitting = true
        } else {
            isAvailableSplitting = false
        }
    }
    
    func fetchPlayers() {
        let storedPlayers = playerManager.fetchPlayers()
        members = storedPlayers.compactMap { $0.mapToModel() }
        memeberId = members.first?.id
    }
    
    func addMember(_ member: PlayerModel?) {
        guard let member else {
            return
        }
        
        members.append(member)
        memeberId = member.id
        playerManager.addPlayer(member)
    }
    
    func removePlayer() {
        guard let memeberId, let index = members.firstIndex(where: { $0.id == memeberId }) else {
            return
        }
        
        playerManager.deletePlayer(by: memeberId)
        members.remove(at: index)

        if index != 0 {
            self.memeberId = members[index - 1].id
        }
    }
}
