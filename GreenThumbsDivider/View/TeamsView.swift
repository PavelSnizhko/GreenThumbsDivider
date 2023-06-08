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
    
    @State private var showSettings = false
    
    init(vm: TeamsViewModel) {
        self.vm = vm
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
            .toolbar {
                //            ToolbarItem(placement: .principal) {
                //                Text("Game")
                //                    .font(.system(size: 20, weight: .bold, design: .default))
                //            }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            //                            vm.showStats.toggle()
                        }
                    } label: {
                        Image(systemName: "chart.bar")
                    }
                    .foregroundColor(.green)
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .foregroundColor(.green)
                }
            }
            .navigationBarBackButtonHidden(true)
    }
    
    func teamViews() -> some View {
        let options: ScaleTransformViewOptions = .layout(.linear)
        let teams = vm.assignMembersToTeams()
        
        return ForEach(teams.sorted(by: { $0.key < $1.key }), id: \.key) { key, players in
            VStack(spacing: 40) {
                ScalePageView(players) { player in
//                    FifaCardView(vm: FifaCardViewModel(model: player), )
//                        .frame(height: 300)
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

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView(vm: TeamsViewModel(members: [Player(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_1"), country: UIImage(named: "Ukraine")!, playerPosition: .centerBack),
                                               Player(id: UUID(), name: "Dmytro", nickName: "Snizhko", image: UIImage(named: "test_1"), country: UIImage(named: "Ukraine")!, playerPosition: .centerBack),
                                               Player(id: UUID(), name: "Sashko", nickName: "Snizhko", image: UIImage(named: "test_1"), country: UIImage(named: "Ukraine")!, playerPosition: .centerBack)], teamCount: 2, goalkeeperCount: 1))
        //                                               Player(id: UUID(), name: "Dmytro", nickName: "Snizhko", image: UIImage(named: "test_1"), country: UIImage(named: "Ukraine")!, playerPosition: .centerBack),
        //                                               Player(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_1"), country: UIImage(named: "Ukraine")!, playerPosition: .centerBack)))
    }
}
