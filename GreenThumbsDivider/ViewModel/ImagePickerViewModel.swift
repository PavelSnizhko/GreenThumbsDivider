//
//  CountryPickerViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 08.05.2023.
//

import SwiftUI

final class ImagePickerViewModel: ObservableObject {
    let source: [String]
    
    @Published var selectedImageIndex = 0
    
    init(source: [String]) {
        self.source = source
    }
    
    var selectedImage: UIImage {
        UIImage(named: source[selectedImageIndex])!
    }
    
}
