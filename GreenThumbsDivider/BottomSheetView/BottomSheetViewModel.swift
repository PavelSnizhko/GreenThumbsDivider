//
//  BottomSheetViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 26.04.2023.
//

import SwiftUI
import PhotosUI
import Combine

@MainActor
class BottomSheetViewModel: ObservableObject {
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
    
    var playerPosition: Position = .winger
    
    init(sheetSize: Binding<PresentationDetent>) {
        self._sheetSize = sheetSize
    }
    
    var isDoneButtonAvailable: Bool {
        !name.isEmpty && !surname.isEmpty
    }
        
    var member: Player? {
        guard let contryImage, let club else {
            return nil
        }
        
        return Player(id: UUID(),
                      name: name,
                      nickName: surname,
                      image: image ?? UIImage(named: "default_image"),
                      club: club,
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
    
    @Published var isNameFieldValid: Bool = true
    @Published var isSurnameVali: Bool = true

    func checkFields() {
        isNameFieldValid = !name.isEmpty
        isSurnameVali = !surname.isEmpty
    }
    
}
