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
            //            VStack {
            //                LineDivider(text: "Goalkeeper", lineColor: .black)
            //                goalkeeperViews()
            //            }
                .frame(maxWidth: .infinity)
            
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.purple, .cyan, .yellow]), startPoint: .top, endPoint: .bottom)
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Заруба")
                    .font(.system(size: 20, weight: .bold, design: .default))
            }
        }
    }
    
    //TODO: add in the right up corner the line with mark GK.
    func goalkeeperViews() -> some View {
        HStack {
            ForEach(Array(zip(vm.teams.goalkeepers.values, vm.shapes.shuffled())), id: \.0.id) { (goalkeeper, shape) in
                VStack {
                    Image(uiImage: goalkeeper.image ?? UIImage())
                        .resizable()
                        .clipShape(shape)
                        .frame(width: 150, height: 150)
                        .aspectRatio(contentMode: .fill)
                    Text(goalkeeper.name)
                }
            }
        }
    }
    
    func teamViews() -> some View {
        var options: ScaleTransformViewOptions {
            .layout(.linear)
        }
        
        return ForEach(vm.teamsAndShapes, id: \.0.key) { (team, shape) in
            VStack(spacing: 40) {
                ScalePageView(team.value) { item in
                    FifaCardView()
                        .frame(height: 300)
                }.options(options)
                    .pagePadding(vertical: .absolute(20),
                                 horizontal: .absolute(80))
                    .frame(height: 300)
            }
            //            .frame(maxHeight: .infinity)
            if team.key != vm.teams.teamMembers.keys.count - 1 {
                LineDivider(text: "VS", lineColor: .black)
                    .foregroundColor(.green)
            }
        }
    }
}

struct LineDivider: View {
    let text: String
    let lineColor: Color
    
    var body: some View {
        HStack {
            lineColor.frame(height: 2)
                .padding(.leading, 20)
            Text(text)
                .font(.system(size: 20, weight: .heavy))
            lineColor.frame(height: 2)
                .padding(.trailing, 20)
        }
    }
}


struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView(vm: TeamsViewModel(members: [Player(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_1")),
                                               Player(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_2")),
                                               Player(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_3"))], teamCount: 2, goalkeeperCount: 1))
    }
}
