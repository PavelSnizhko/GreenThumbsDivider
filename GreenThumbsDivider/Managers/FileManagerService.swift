//
//  FileManagerService.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 25.04.2023.
//

import Foundation

final class FileManagerService {
    
    private init () { }
    
    static let shared = FileManagerService()
    
    func save(members: [Player]) {
        do {
            let data = try JSONEncoder().encode(members)
            let url = FileManager.documentsDirectory.appendingPathComponent(Constants.fileName)
            try data.write(to: url)
        } catch {
            print("Failed to save members: \(error)")
        }
    }
    
    func loadMembers() -> [Player] {
        let url = FileManager.documentsDirectory.appendingPathComponent(Constants.fileName)
        do {
            let data = try Data(contentsOf: url)
            let members = try JSONDecoder().decode([Player].self, from: data)
            return members
        } catch {
            print("Failed to load members: \(error)")
            return []
        }
    }
    
    func add(member: Player) {
        var members = loadMembers()
        members.append(member)
        save(members: members)
    }
}

extension FileManagerService {
    
    enum Constants {
        static let fileName = "members.json"
    }
    
}
