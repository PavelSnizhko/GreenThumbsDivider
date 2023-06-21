//
//  TeamsView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 24.04.2023.
//

import SwiftUI
import CollectionViewPagingLayout

struct TeamsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    @StateObject private var vm: TeamsViewModel
    private let isSmallHeightSize =  UIScreen.main.bounds.height <= DeviceScreenSize.iPhone8.screenHeight
    
    @State private var showingBottomSheet = false
    @State var buttonsDisabled: [Int: Bool] = [:]
    
    init(vm: TeamsViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            teamViews()
            NavigationLink(destination:  GameView(), label: {
                Text("Play")
            })
            .buttonStyle(MainButtonStyle(color: .red, textColor: .white))
            .frame(width: 200, height: 50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.purple, .cyan, .yellow]), startPoint: .top, endPoint: .bottom)
        )
        .frame(maxHeight: .infinity)
        .sheet(isPresented: $showingBottomSheet) {
            TeamsViewBottomSheet(isPresented: $showingBottomSheet,
                                 vm: TeamsViewBottomSheetViewModel(teamMembers: vm.selectedPlayers,
                                                                   manageObjectContext: managedObjectContext))
        }
    }
    
    
    func teamViews() -> some View {
        let options: ScaleTransformViewOptions = .layout(.linear)
        let teams = vm.assignMembersToTeams()
        
        return ForEach(teams.sorted(by: { $0.key < $1.key }), id: \.key) { key, players in
            VStack(spacing: 40) {
                ZStack(alignment: .bottomTrailing) {
                    ScalePageView(players) { player in
                        if isSmallHeightSize {
                            FifaCardView(vm: FifaCardViewModel(model: player), cardSize: CGSize(width: 200, height: 260))
                        } else {
                            FifaCardView(vm: FifaCardViewModel(model: player), cardSize: CGSize(width: 200, height: 300))
                        }
                    }.options(options)
                        .pagePadding(vertical: .absolute(20),
                                     horizontal: .absolute(80))
                        .frame(height: 300)
                    Button {
                        showingBottomSheet = true
                        vm.showTeamsStoringButtonDisabled[key] = true
                        vm.selectedPlayers = players
                        print("Save team: \(players)")
                    } label: {
                        Text("Save team")
                            .frame(width: 100, height: 50)
                            .background(Color.purple)
                            .cornerRadius(20)
                            .padding(.trailing, 10)
                            .foregroundColor(.white)
                    }
                    .disabled(vm.showTeamsStoringButtonDisabled[key] ?? false)
                }
            }
            if key != teams.keys.count - 1 {
                LineDivider(text: "VS", lineColor: .black)
                    .foregroundColor(.green)
            }
        }
    }
}


struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView(vm: TeamsViewModel(members: [PlayerModel(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_1"), country: UIImage(named: "Ukraine")!, playerPosition: .centerBack),
                                               PlayerModel(id: UUID(), name: "Dmytro", nickName: "Snizhko", image: UIImage(named: "test_1"), country: UIImage(named: "Ukraine")!, playerPosition: .centerBack),
                                               PlayerModel(id: UUID(), name: "Sashko", nickName: "Snizhko", image: UIImage(named: "test_1"), country: UIImage(named: "Ukraine")!, playerPosition: .centerBack)], teamCount: 2, goalkeeperCount: 1))
        //                                               Player(id: UUID(), name: "Dmytro", nickName: "Snizhko", image: UIImage(named: "test_1"), country: UIImage(named: "Ukraine")!, playerPosition: .centerBack),
        //                                               Player(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_1"), country: UIImage(named: "Ukraine")!, playerPosition: .centerBack)))
    }
}
