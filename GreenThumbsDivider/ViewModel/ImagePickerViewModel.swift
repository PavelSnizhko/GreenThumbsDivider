//
//  CountryPickerViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 08.05.2023.
//

import SwiftUI
import Combine

final class ImagePickerViewModel: ObservableObject {
    let source: [String]
    
    @Published var selectedImageIndex: Int
    
    init(source: [String], initialSelectedIndex: Int = 0) {
        self.source = source
        selectedImageIndex = initialSelectedIndex
    }
    
    var selectedImage: UIImage {
        UIImage(named: source[selectedImageIndex])!
    }
    
}
