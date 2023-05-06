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
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "004ff9"), Color(hex: "fff94c")]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .ignoresSafeArea()
                VStack {
                    dividerCard
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
                .padding(.init(top: 40, leading: 16, bottom: 40, trailing: 16))
            }
        }
    }
    
}

//MARK: - Views

extension SplitTeamView {
    
    //MARK: - Divider Section
    
    var dividerCard: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("\(Constant.teamsTitle): \(playerViewModel.teams)")
                
                Stepper("\(Constant.goalkeepersTittle): \(playerViewModel.goalkeeper)",
                        value: $playerViewModel.goalkeeper,
                        in: 1...2,
                        step: 1)
            }
            .font(.system(size: 22, weight: .bold, design: .monospaced))
            .lineLimit(1)
            Button(action: { },
                   label: {
                NavigationLink {
                    TeamsView(vm: TeamsViewModel(members: playerViewModel.members,
                                                 teamCount: playerViewModel.teams,
                                                 goalkeeperCount: playerViewModel.goalkeeper))
                } label: {
                    Text("\(Constant.buttonActionTtite)")
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 124 / 255, green: 222 / 255, blue: 220 / 255))
                        .cornerRadius(10)
                }
            })
            .disabled(!playerViewModel.isAvailableSplitting)
        }
        .padding(30)
        .background(.cyan)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    //MARK: - Placeholder
    
    var placeholder: some View {
        ZStack {
            Color.white
                .opacity(0.4)
            VStack {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .resizable()
                    .frame(width: 100, height: 80)
                Text(Constant.placeholderDescription)
                    .font(.system(size: 22, weight: .light, design: .rounded))
                    .multilineTextAlignment(.center)
                
            }
            .foregroundColor(Color(hex: "0075C4"))
            .onTapGesture {
                showingBottomSheet = true
            }
        }
        .frame(height: 300)
        .cornerRadius(20)
    }
    
    //MARK: - Player cards
    
    var membersSelectionView: some View {
        VStack {
            if playerViewModel.isPlaceholderVisisble {
                placeholder
            } else {
                ScalePageView(playerViewModel.members,
                              selection: $playerViewModel.memeberId) { item in
                    FifaCardView(vm: FifaCardViewModel(model: item))
                }
                              .options(.layout(.linear))
                              .pagePadding(vertical: .absolute(100),
                                           horizontal: .absolute(80))
                              .ignoresSafeArea()
            }
            
            if !playerViewModel.isPlaceholderVisisble {
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
                    
                    .clipShape(Circle())
                }
            }
        }
        .sheet(isPresented: $showingBottomSheet, content: {
            BottomSheetView(viewModel: .init(sheetSize: $sheetSize),
                            isPresented: $showingBottomSheet) { member in
                playerViewModel.addMember(member)
            }
                            .presentationDetents([.medium, .large], selection: $sheetSize)
                            .presentationDragIndicator(.visible)
        })
        .onAppear {
            playerViewModel.fetchImages()
        }
    }
}

//MARK: - Constatns

private extension SplitTeamView {
    enum Constant {
        static let teamsTitle = "Teams"
        static let goalkeepersTittle = "Goalkeepers"
        static let buttonActionTtite = "Divide"
        static let placeholderDescription = "Tap to add team members"
    }
}


struct SplitTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SplitTeamView()
    }
}
