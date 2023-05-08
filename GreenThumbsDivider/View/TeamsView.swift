//
//  TeamsView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 24.04.2023.
//

import SwiftUI
import CollectionViewPagingLayout

struct TeamsView: View {
    private var vm: TeamsViewModel
    
    init(vm: TeamsViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack(spacing: 10) {
            teamViews()
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.purple, .cyan, .yellow]), startPoint: .top, endPoint: .bottom)
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Game")
                    .font(.system(size: 20, weight: .bold, design: .default))
            }
        }
    }
        
    func teamViews() -> some View {
        let options: ScaleTransformViewOptions = .layout(.linear)
        let teams = vm.assignMembersToTeams()
        
        return ForEach(teams.sorted(by: { $0.key < $1.key }), id: \.key) { key, players in
                VStack(spacing: 40) {
                    ScalePageView(players) { player in
                        FifaCardView(vm: FifaCardViewModel(model: player))
                            .frame(height: 300)
                    }.options(options)
                        .pagePadding(vertical: .absolute(20),
                                     horizontal: .absolute(80))
                        .frame(height: 300)
                }
                if key != teams.keys.count - 1 {
                    LineDivider(text: "VS", lineColor: .black)
                        .foregroundColor(.green)
                }
            }
        }
}

//struct TeamsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamsView(vm: TeamsViewModel(members: [Player(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_1")),
//                                               Player(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_2")),
//                                               Player(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_3"))], teamCount: 2, goalkeeperCount: 1))
//    }
//}
