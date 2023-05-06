//
//  Skills.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 04.05.2023.
//

import Foundation

enum Skills: Codable, Hashable, CaseIterable {
    static var allCases: [Skills] = [.pac(0), .sho(0), .pas(0), .dri(0), .def(0), .phy(0)]
    
    case pac(Int)
    case sho(Int)
    case pas(Int)
    case dri(Int)
    case def(Int)
    case phy(Int)
    
    var desciption: String {
        switch self {
        case .pac(_):
            return "PAC"
        case .sho(_):
            return "SHO"
        case .pas(_):
            return "PAS"
        case .dri(_):
            return "DRI"
        case .def(_):
            return "DEF"
        case .phy(_):
            return "PHY"
        }
    }
    
    var concatenatedDesciption: String {
        switch self {
        case let .pac(value):
            return "\(value) PAC"
        case let .sho(value):
            return "\(value) SHO"
        case let .pas(value):
            return "\(value) PAS"
        case let .dri(value):
            return "\(value) DRI"
        case let .def(value):
            return "\(value) DEF"
        case let .phy(value):
            return "\(value) PHY"
        }
    }
    
    var number: Int {
        switch self {
        case let .pac(value):
            return value
        case let .sho(value):
            return value
        case let .pas(value):
            return value
        case let .dri(value):
            return value
        case let .def(value):
            return value
        case let .phy(value):
            return value
        }
    }
    
    static func mapToSkills(from dict: [String: Double]) -> [Skills] {
        dict.map { (key, value) in
            let intValue = Int(value)
            
            switch key.lowercased() {
            case "pac":
                return .pac(intValue)
            case "sho":
                return .sho(intValue)
            case "pas":
                return .pas(intValue)
            case "dri":
                return .dri(intValue)
            case "def":
                return .def(intValue)
            case "phy":
                return .phy(intValue)
            default:
                assertionFailure("There is an extra enum case")
                return .pac(intValue)
            }
        }
    }
}
