//
//  SplitTeamView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 10.04.2023.
//

import SwiftUI
import PhotosUI
import CollectionViewPagingLayout

struct SplitTeamView: View {
    @StateObject private var playerViewModel = PlayerViewModel()
    @State var showingBottomSheet = false
    @State var sheetSize: PresentationDetent = .large
        
    var options: ScaleTransformViewOptions {
        .layout(.linear)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Команди: \(playerViewModel.teams)")
                    Stepper("Воротар: \(playerViewModel.goalkeeper)",
                            value: $playerViewModel.goalkeeper,
                            in: 1...2,
                            step: 1)
                }
                .font(.title3)
                Button(action: {
                    
                }, label: {
                    NavigationLink {
                        TeamsView(vm: TeamsViewModel(members: playerViewModel.members,
                                                     teamCount: playerViewModel.teams,
                                                     goalkeeperCount: playerViewModel.goalkeeper))
                    } label: {
                        Text("Поділитись")
                            .frame(width: 280, height: 50)
                            .background(Color(red: 124 / 255, green: 222 / 255, blue: 220 / 255))
                            .cornerRadius(10)
                    }
                })
                .disabled(!playerViewModel.isAvailableSplitting)
                .padding(.top, 50)
                Spacer()
                membersSelectionView
            }.onChange(of: playerViewModel.members, perform: { members in
                playerViewModel.isAvailableSplitting(for: members)
            })
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
            ScalePageView(playerViewModel.members,
                          selection: $playerViewModel.memeberId) { item in
                FifaCardView(vm: FifaCardViewModel(model: item))
            }
                          .options(options)
                          .pagePadding(vertical: .absolute(100),
                                       horizontal: .absolute(80))
                        
            HStack {
                Button(action: {
                    playerViewModel.removePlayer()
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
                    BottomSheetView(viewModel: .init(sheetSize: $sheetSize),
                                    isPresented: $showingBottomSheet) { member in
                        playerViewModel.addMember(member)
                    }
                                    .presentationDetents([.medium, .large], selection: $sheetSize)
                    .presentationDragIndicator(.visible)
                })
                .clipShape(Circle())
            }
        }.onAppear {
            playerViewModel.fetchImages()
        }
    }
}


struct SplitTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SplitTeamView()
    }
}
