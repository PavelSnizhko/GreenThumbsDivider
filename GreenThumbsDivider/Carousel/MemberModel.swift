//
//  ImageModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 11.04.2023.
//

import SwiftUI

struct MemberModel: Identifiable, Equatable, Hashable {
    let id: UUID
    let name: String
    let nickName: String
    var image: UIImage?
}

extension MemberModel: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nickName
        case imageData
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        nickName = try container.decode(String.self, forKey: .nickName)
        
        if let imageData = try container.decodeIfPresent(Data.self, forKey: .imageData) {
            image = UIImage(data: imageData)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(nickName, forKey: .nickName)
        
        if let image = image, let imageData = image.jpegData(compressionQuality: 1.0) {
            try container.encode(imageData, forKey: .imageData)
        }
    }
    
    
}

