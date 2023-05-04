//
//  CarouselViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 11.04.2023.
//

import Foundation

class CarouselViewModel: ObservableObject {
    @Published var members: [MemberModel] = []
    @Published var memeberId: UUID?
    
    func fetchImages() {
        members = FileManagerService.shared.loadMembers()
        memeberId = members[0].id
    }
    
    func addMember(_ member: MemberModel?) {
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


