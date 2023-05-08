//
//  FifaCardViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 04.05.2023.
//

import SwiftUI

struct FifaCardViewModel {
    let model: Player
    
    var nickname: String {
        model.nickName.uppercased()
    }

    var skills: [String] {
        model.skills.map { skill in
            skill.concatenatedDesciption
        }
    }
    
    var countryImage: UIImage {
        model.country
    }
    
    var talent: Int {
        model.skills.map(\.number).reduce(0, +) / model.skills.count
    }
    
    var position: String {
        model.playerPosition.abbreviation.uppercased()
    }
    
    var showTape: Bool {
        model.isGoalkeeper
    }
    
}
