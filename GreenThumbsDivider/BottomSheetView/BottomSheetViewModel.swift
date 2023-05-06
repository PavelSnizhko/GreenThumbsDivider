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
    @Published var club: UIImage?
    
    @Published var skills: [Skills] = []
    
    @Published var showPicker: Bool = false
    @Published var source: SourcePicker.Source = .library
    
    @Published var contryImage: UIImage?
    
    @Published var image: UIImage? {
        didSet {
            sheetSize = .large
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
        guard let image, let contryImage else {
            return nil
        }
        
        return Player(id: UUID(),
                      name: name,
                      nickName: surname,
                      image: image,
                      country: contryImage,
                      skills: skills,
                      playerPosition: .centerBack)
    }
       
    func showPhotoPicker() {
        if source == .camera, !SourcePicker.checkPermissions() {
            print("There is no Camera")
            return
        }
        showPicker = true
    }
    
}
