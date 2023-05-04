//
//  SplitTeamViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 27.04.2023.
//

import SwiftUI

class SplitTeamViewModel: ObservableObject {
    @Published var teams: Int = 2
    @Published var goalkeeper: Int = 1
    
    @Published var isAvailableSplitting: Bool = false
    @Published var sheetSize: PresentationDetent = .height(300)
    
    func isAvailableSplitting(for members: [Player]) {
        if members.count > 3 || (members.count == 3 && goalkeeper == 1) {
            isAvailableSplitting = true
        } else {
            isAvailableSplitting = false
        }
    }
}
