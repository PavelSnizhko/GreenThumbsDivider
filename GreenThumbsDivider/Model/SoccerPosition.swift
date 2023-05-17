//
//  Position.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 04.05.2023.
//

import Foundation

enum Position: String, CaseIterable, Codable, Hashable {
    case goalkeeper = "Goalkeeper"
    case centerBack = "Center Back"
    case fullBack = "Full Back"
    case defensiveMidfielder = "Defensive Midfielder"
    case centralMidfielder = "Central Midfielder"
    case attackingMidfielder = "Attacking Midfielder"
    case winger = "Winger"
    case forward = "Forward"
    
    var abbreviation: String {
        switch self {
        case .goalkeeper:
            return "GK"
        case .centerBack:
            return "CB"
        case .fullBack:
            return "FB"
        case .defensiveMidfielder:
            return "DM"
        case .centralMidfielder:
            return "CM"
        case .attackingMidfielder:
            return "AM"
        case .winger:
            return "WG"
        case .forward:
            return "FW"
        }
    }
}
