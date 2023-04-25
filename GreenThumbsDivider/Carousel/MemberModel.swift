//
//  ImageModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 11.04.2023.
//

import Foundation

struct MemberModel: Identifiable, Equatable, Hashable {
    let id: UUID
    let imageName: String
    let name: String
    let nickName: String
    var imageURL: URL?
}

extension MemberModel: Codable {}

