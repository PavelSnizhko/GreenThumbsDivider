//
//  FileManager+DocumentsDirectory.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 24.04.2023.
//

import Foundation

extension FileManager {
    
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}

