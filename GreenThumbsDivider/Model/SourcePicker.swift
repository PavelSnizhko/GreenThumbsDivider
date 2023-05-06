//
//  SourcePicker.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 26.04.2023.
//

import SwiftUI

enum SourcePicker {
    enum Source {
        case library, camera
    }
    
    static func checkPermissions() -> Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
}
