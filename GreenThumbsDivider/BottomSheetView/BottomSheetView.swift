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
    @StateObject var clubPickerViewModel = ImagePickerViewModel(source: ["Arsenal", "Barcelona", "Chelsea", "Dynamo", "Milan", "Real Madrid", "Shakhtar", "Green Thumbs"])
    @StateObject var skillsVieModel = SkillsViewModel()
    @Binding var isPresented: Bool
    
    var result: (PlayerModel?) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("New player")
                    .font(.headline)
                
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                }
                textfileds
                pickerViews
                SkillsSliderView(vm: skillsVieModel)
                    .frame(height: 150)
                
                photoPickers
                .padding(.top, 20)
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.vertical, 30)
            .background(Color.white)
            .cornerRadius(30)
            .padding([.horizontal, .top], 20)
            .animation(.spring())
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

private extension BottomSheetView {
    
    var pickerViews: some View {
        Group {
            LabeledContent(content: {
                PickerView(vm: countryPickerViewModel, pickerStyle: .wheel)
                    .frame(width: 200, height: 100)
            }, label: {
                Text("Country:").font(.system(size: 18, weight: .medium, design: .rounded))
            })
            LabeledContent(content: {
                PickerView(vm: clubPickerViewModel, pickerStyle: .wheel)
                    .frame(width: 200, height: 100)
            }, label: {
                Text("Club:").font(.system(size: 18, weight: .medium, design: .rounded))
            })

        }
        .padding(.horizontal, 16)
    }
    
    var photoPickers: some View {
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
//            viewModel.playerPosition = skillsVieModel.mapPosition(from: <#T##String#>)
            viewModel.club = clubPickerViewModel.selectedImage
            result(viewModel.member)
        }
        .sheet(isPresented: $viewModel.showPicker){
            ImagePicker(sourceType: viewModel.source == .library ? .photoLibrary : .camera,
                        selectedImage: $viewModel.image)
            .ignoresSafeArea()
        }
    }
    
    var textfileds: some View {
        VStack(spacing: 5) {
            Group {
                TextField("Name", text: $viewModel.name)
                    
                TextField("Surname", text: $viewModel.surname)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 16)
        }
        
    }
    
    var doneButton: some View {
        Button {
            viewModel.checkFields()
            isPresented.toggle()
        } label: {
            HStack {
                Text("Done")
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
    
    enum Field: Int, CaseIterable {
        case name, surname
    }
}


struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(viewModel: BottomSheetViewModel(sheetSize: .constant(.medium)), isPresented: .constant(true), result: {_ in})
    }
}
