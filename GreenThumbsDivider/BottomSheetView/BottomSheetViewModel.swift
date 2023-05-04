//
//  BottomSheetViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 26.04.2023.
//

import SwiftUI
import PhotosUI

@MainActor class BottomSheetViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var selectedImage: UIImage?
    
    @Published var showPicker: Bool = false
    @Published var source: Picker.Source = .library
    
    @Published var image: UIImage? {
        didSet {
            sheetSize = .height(500)
        }
    }
    
    @Binding var sheetSize: PresentationDetent
    
    init(sheetSize: Binding<PresentationDetent>) {
        self._sheetSize = sheetSize
    }
    
    var isDoneButtonAvailable: Bool {
        !name.isEmpty && !surname.isEmpty && image != nil
    }
        
    var member: Player? {
        guard let image else {
            return nil
        }
        
        return Player(id: UUID(), name: name, nickName: surname, image: image)
    }
       
    func showPhotoPicker() {
        if source == .camera, !Picker.checkPermissions() {
            print("There is no Camera")
            return
        }
        showPicker = true
    }
    
}
