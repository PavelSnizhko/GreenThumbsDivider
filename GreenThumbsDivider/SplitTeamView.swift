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
                        TeamsView(vm: TeamsViewModel(members: carouselViewModel.members, teamCount: 2))
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
                    //togle bottom sheet
                    showingBottomSheet = true
                }, label: {
                    Image("plus")
                        .frame(width: 40, height: 40)
                        .background(Color(red: 143 / 255, green: 149 / 255, blue: 211 / 255))
                    
                })
                .sheet(isPresented: $showingBottomSheet, content: {
                    BottomSheetView(viewModel: .init()) { member in
                        carouselViewModel.addMember(member)
                    }
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                })
                .clipShape(Circle())
            }
        }
    }
}


struct SplitTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SplitTeamView()
    }
}
