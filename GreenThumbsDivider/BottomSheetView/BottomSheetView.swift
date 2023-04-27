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
    
    var result: (MemberModel?) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Add a new player")
                .font(.headline)
                .padding(.top, 20)
            
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(minWidth: 0, maxWidth: 200)
                    .frame(minHeight: 0, maxHeight: 200)
                    .aspectRatio(contentMode: .fill)
            }
            
            TextField("Name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
            
            TextField("Surname", text: $viewModel.surname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
            
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
            }
            .onDisappear {
                result(viewModel.member)

            }.sheet(isPresented: $viewModel.showPicker){
                    ImagePicker(sourceType: viewModel.source == .library ? .photoLibrary : .camera,
                                selectedImage: $viewModel.image)
                        .ignoresSafeArea()
            }
            .padding(.top, 20)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.vertical, 30)
        .background(Color.white)
        .cornerRadius(30)
        .padding(.horizontal, 20)
        .animation(.spring())
        .edgesIgnoringSafeArea(.bottom)
    }
}
