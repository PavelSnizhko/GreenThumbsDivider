//
//  CarouselViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 11.04.2023.
//

import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published var members: [Player] = []
    @Published var memeberId: UUID?
    
    @Published var teams: Int = 2
    @Published var goalkeeper: Int = 1
    
    @Published var isAvailableSplitting: Bool = false
    
    var isPlaceholderVisisble: Bool {
        members.count == 0
    }
    
    func isAvailableSplitting(for members: [Player]) {
        if members.count > 3 || (members.count == 3 && goalkeeper == 1) {
            isAvailableSplitting = true
        } else {
            isAvailableSplitting = false
        }
    }
    
    func fetchImages() {
        members = FileManagerService.shared.loadMembers()
        memeberId = members.first?.id
    }
    
    func addMember(_ member: Player?) {
        guard let member else {
            return
        }
        
        members.append(member)
        memeberId = member.id
        FileManagerService.shared.add(member: member)
    }
    
    func removePlayer() {
        guard let memeberId else {
            return
        }
        
        if let index = members.firstIndex(where: { $0.id == memeberId }) {
            members.remove(at: index)
            FileManagerService.shared.save(members: members)
            
            if index != 0 {
                self.memeberId = members[index - 1].id
            }
        }
    }
}


