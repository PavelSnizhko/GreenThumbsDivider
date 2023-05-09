//
//  BottomSheetView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 26.04.2023.
//

import SwiftUI
import PhotosUI

struct BottomSheetView: View {
    @StateObject var viewModel: BottomSheetViewModel
    @StateObject var countryPickerViewModel = ImagePickerViewModel(source: ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "US", "Ukraine"])
//    @StateObject var clubPickerViewModel = ImagePickerViewModel(source: ["Arsenal", "Barcelona", "Chelsea", "Dynamo", "Milan", "Real Madrid", "Shakhtar", "Green Thumbs"])
    @StateObject var skillsVieModel = SkillsViewModel()
    @Binding var isPresented: Bool
    
    var result: (Player?) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Add a new player")
                    .font(.headline)
                
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                }
                
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                TextField("Surname", text: $viewModel.surname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                PickerView(vm: countryPickerViewModel, pickerStyle: .wheel)
                    .frame(width: 100, height: 100)
                SkillsSliderView(vm: skillsVieModel)
                    .frame(height: 150)
                
                HStack(spacing: 20) {
                    Button(action: {
                        viewModel.showPicker = true
                        viewModel.showPhotoPicker()
                    }, label: {
                        Image(systemName: "photo")
                            .foregroundColor(.blue)
                    })
                    
                    Button(action: {
                        viewModel.showPicker = true
                        viewModel.showPhotoPicker()
                    }, label: {
                        Image(systemName: "camera")
                            .foregroundColor(.blue)
                    })
                    doneButton
                }
                .onDisappear {
                    viewModel.contryImage = countryPickerViewModel.selectedImage
                    viewModel.skills = Skills.mapToSkills(from: skillsVieModel.skills) 
                    result(viewModel.member)
                    
                }.sheet(isPresented: $viewModel.showPicker){
                    ImagePicker(sourceType: viewModel.source == .library ? .photoLibrary : .camera,
                                selectedImage: $viewModel.image)
                    .ignoresSafeArea()
                }
                .padding(.top, 20)
                Spacer()
            }
            .padding(.top, 10)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical, 30)
            .background(Color.white)
            .cornerRadius(30)
            .padding(.horizontal, 20)
            .animation(.spring())
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

extension BottomSheetView {
    
    var doneButton: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Text("Готово")
            }
            .font(.headline)
            .padding()
            .frame(height: 35)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(15)
        }
        .disabled(!viewModel.isDoneButtonAvailable)
    }
}


struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(viewModel: BottomSheetViewModel(sheetSize: .constant(.medium)), isPresented: .constant(true), result: {_ in})
    }
}
