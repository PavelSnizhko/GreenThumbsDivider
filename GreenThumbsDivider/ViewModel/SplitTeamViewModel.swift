//
//  SplitTeamViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 27.04.2023.
//

import Foundation

class SplitTeamViewModel: ObservableObject {
    @Published var teams: Int = 2
    @Published var goalkeeper: Int = 1
    
    @Published var isAvailableSplitting: Bool = false
    
    func isAvailableSplitting(for members: [MemberModel]) {
        if members.count > 3 || (members.count == 3 && goalkeeper == 1) {
            isAvailableSplitting = true
        } else {
            isAvailableSplitting = false
        }
    }
}
