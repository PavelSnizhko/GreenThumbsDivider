//
//  ImageModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 11.04.2023.
//

import SwiftUI

struct Player: Identifiable, Hashable {
    let id: UUID
    let name: String
    let nickName: String
    var image: UIImage?
    var isGoalkeeper: Bool = false
    var club: UIImage? = UIImage(named: "logo")
    var country: UIImage
    var skills: [Skills] = [.def(0), .dri(0), .pac(0), .pas(0), .phy(0), .sho(0)]
    var playerPosition: Position
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.nickName == rhs.nickName
    }
}

extension Player: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nickName
        case imageData
        case club
        case country
        case skills
        case position
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        nickName = try container.decode(String.self, forKey: .nickName)
        
        if let imageData = try container.decodeIfPresent(Data.self, forKey: .imageData) {
            image = UIImage(data: imageData)
        }
        
        if let imageData = try container.decodeIfPresent(Data.self, forKey: .club) {
            club = UIImage(data: imageData)
        }
        
        country = UIImage(data: try container.decode(Data.self, forKey: .country)) ?? UIImage()
        skills = try container.decode([Skills].self, forKey: .skills)
        playerPosition = try container.decode(Position.self, forKey: .position)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(nickName, forKey: .nickName)
        try container.encode(skills, forKey: .skills)
        try container.encode(playerPosition, forKey: .position)

        if let countryImageData = country.jpegData(compressionQuality: 1.0) {
            try container.encode(countryImageData, forKey: .country)
        }
        
        if let club, let clubImageData = club.jpegData(compressionQuality: 1.0) {
            try container.encode(clubImageData, forKey: .club)
        }
        
        if let image = image, let imageData = image.jpegData(compressionQuality: 1.0) {
            try container.encode(imageData, forKey: .imageData)
        }
    }
    
}

