//
//  CarouselViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 11.04.2023.
//

import Foundation

class CarouselViewModel: ObservableObject {
    @Published var members: [MemberModel] = []
    @Published private(set) var selectedMember: MemberModel?
    
    func fetchImages() {
        members = FileManagerService.shared.loadMembers()
        selectedMember = members.first
    }
    
    func selectMember(_ image: MemberModel?) {
        selectedMember = image
    }
    
    func addMember(_ member: MemberModel) {
        members.append(member)
        FileManagerService.shared.add(member: member)
        selectMember(member)
    }
    
    func removePlayer() {
        guard let selectedMember else {
            return
        }
        
        if let index = members.firstIndex(where: { $0.id == selectedMember.id }) {
            selectMember(nil)
            members.remove(at: index)
            FileManagerService.shared.save(members: members)
        }
    }
}


