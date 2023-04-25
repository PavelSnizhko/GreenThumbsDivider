//
//  SplitTeamView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 10.04.2023.
//

import SwiftUI
import PhotosUI

struct SplitTeamView: View {
    
    @State private var teams: Int = 2
    @State private var goalkeeper: Int = 1
    @StateObject private var carouselViewModel = CarouselViewModel()
    
    @State var showingBottomSheet = false
    
    @State private var isTeamSplited: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack {
                    Stepper("Команди: \(teams)", value: $teams)
                    Stepper("Воротар: \(goalkeeper)", value: $goalkeeper)
                }
                .font(.title3)
                Button(action: {
                    isTeamSplited = true
                    print("Поділитись кнопка")
                }, label: {
                    NavigationLink {
                        TeamsView()
                    } label: {
                        Text("Поділитись")
                            .frame(width: 280, height: 50)
                            .background(Color(red: 124 / 255, green: 222 / 255, blue: 220 / 255))
                            .cornerRadius(10)
                    }
                }).padding(.top, 50)
                Spacer()
                membersSelectionView
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(.init(top: 40, leading: 36, bottom: 40, trailing: 36))
        }
    }
    
}

extension SplitTeamView {
    
    var membersSelectionView: some View {
        VStack {
            CarouselView(viewModel: carouselViewModel)
            
            HStack {
                Button(action: {
                    carouselViewModel.removePlayer()
                }, label: {
                    Image("minus")
                        .frame(width: 40, height: 40)
                        .background(Color(red: 122 / 255, green: 121 / 255, blue: 120 / 255))
                })
                .clipShape(Circle())
                
                Button(action: {
                    let newImage = MemberModel(id: UUID(), imageName: "plus", name: "Paul", nickName: "Puyol", imageURL: nil)
                    carouselViewModel.addMember(newImage)
                    
                    //togle bottom sheet
                    showingBottomSheet = true
                }, label: {
                    Image("plus")
                        .frame(width: 40, height: 40)
                        .background(Color(red: 143 / 255, green: 149 / 255, blue: 211 / 255))
                    
                })
                .sheet(isPresented: $showingBottomSheet, content: {
                    BottomSheetView(viewModel: .init())
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                })
                .clipShape(Circle())
            }
        }
    }
}

struct BottomSheetView: View {
    @StateObject var viewModel: BottomSheetViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Add a new player")
                .font(.headline)
                .padding(.top, 20)
            
            if let data = viewModel.data, let image = UIImage(data: data) {
                Image(uiImage: image).resizable().frame(minWidth: 0, maxWidth: 200).frame(minHeight: 0, maxHeight: 200)
            }
            
            TextField("Name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
            
            TextField("Surname", text: $viewModel.surname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
            
            HStack(spacing: 20) {
                Button(action: {
                    viewModel.showImagePicker = true
                }, label: {
                    PhotosPicker(selection: $viewModel.selectedItems,
                                 maxSelectionCount: 1,
                                 matching: .images) {
                        Image(systemName: "photo")
                            .foregroundColor(.blue)
                    }.onChange(of: viewModel.selectedItems) { newValue in
                        
                    }
                })
                
                Button(action: {
                    viewModel.showCameraPicker = true
                }, label: {
                    Image(systemName: "camera")
                        .foregroundColor(.blue)
                })
            }
            .onReceive(viewModel.$selectedItems, perform: { item in
                viewModel.convertToData(item: item.first)
            })
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

@MainActor class BottomSheetViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var selectedImage: UIImage?
    @Published var showImagePicker: Bool = false
    @Published var showCameraPicker: Bool = false
    
    @Published var data: Data?
    @Published var selectedItems: [PhotosPickerItem] = []
        
    func convertToData(item: PhotosPickerItem?) {
        guard let item else {
            return
        }
        
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                print("Data is nil")
                return
            }
            self.data = data
        }
    }
    
}




struct SplitTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SplitTeamView()
    }
}
