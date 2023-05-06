//
//  SkillsViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 05.05.2023.
//

import Foundation

class SkillsViewModel: ObservableObject {
    
    @Published var skills: [String: Double] = Dictionary(uniqueKeysWithValues: Skills.allCases.map { ($0.desciption, Double($0.number)) })
    
    let skillsCount = Skills.allCases.count
    lazy var firstSkillsGroup = Skills.allCases.prefix(skillsCount / 2)
    lazy var secondSkillsGroup = Skills.allCases.suffix(skillsCount / 2)
}
