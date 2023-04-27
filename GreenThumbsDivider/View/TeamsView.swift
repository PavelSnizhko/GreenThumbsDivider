//
//  TeamsView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 24.04.2023.
//

import SwiftUI

struct TeamsView: View {
    private var vm: TeamsViewModel
    
    init(vm: TeamsViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack {
//            Spacer()
            teamViews()
//            Spacer()
            Text("Воротар")
                .font(.system(size: 40, weight: .heavy))
                .foregroundColor(.red)
            goalkeeperViews()
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Text("Заруба")
                    .font(.system(size: 20, weight: .bold, design: .default))
            }
        }
    }
    
    func goalkeeperViews() -> some View {
        HStack {
            ForEach(Array(zip(vm.teams.goalkeepers.values, vm.shapes.shuffled())), id: \.0.id) { (goalkeeper, shape) in
                VStack {
                    Image(uiImage: goalkeeper.image ?? UIImage())
                        .resizable()
                        .clipShape(shape)
                        .frame(100, 100)
                        .aspectRatio(contentMode: .fill)
                    Text(goalkeeper.name)
                }
            }
        }
    }
    
    func teamViews() -> some View {
        ForEach(vm.teamsAndShapes, id: \.0.key) { (team, shape) in
            VStack {
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center) {
                            ForEach(team.value, id: \.id) { member in
                                VStack {
                                    Image(uiImage: member.image ?? UIImage())
                                        .resizable()
                                        .clipShape(shape)
                                        .frame(200, 200)
                                        .aspectRatio(contentMode: .fill)
                                    Text("\(member.name)(\(member.nickName))")
                                }
                            }
                        }
                        .frame(minWidth: geometry.size.width)
                    }
                }
                if team.key != vm.teams.teamMembers.keys.count - 1 {
                    HStack {
                        Color.gray.frame(height: 2)
                            .padding(.leading, 20)
                        Text("VS")
                            .font(.system(size: 20, weight: .heavy))
                        Color.gray.frame(height: 2)
                            .padding(.trailing, 20)
                    }
                    .padding([.top, .bottom], 20)
                }
            }
        }
    }
}
