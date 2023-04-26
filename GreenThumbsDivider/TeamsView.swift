//
//  TeamsView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 24.04.2023.
//

import SwiftUI

struct TeamsViewModel {
    var members: [MemberModel]
    let teamCount: Int
    
    func assignMembersToTeams() -> [Int: [MemberModel]] {
        var teams = [Int: [MemberModel]]()
        let totalMembers = members.count
        let membersPerTeam = totalMembers / teamCount
        var extraMembers = totalMembers % teamCount
        
        // Shuffle the members array randomly
        var shuffledMembers = members.shuffled()
        
        // Assign members to each team
        for i in 0..<teamCount {
            var membersForTeam = [MemberModel]()
            
            // Add the standard number of members per team
            for _ in 0..<membersPerTeam {
                membersForTeam.append(shuffledMembers.removeFirst())
            }
            
            // If there are extra members, add one to a random team
            if extraMembers > 0 {
                membersForTeam.append(shuffledMembers.removeFirst())
                extraMembers -= 1
            }
            
            // Add the team to the dictionary of teams
            teams[i] = membersForTeam
        }
        
        return teams
    }
    
    private func removeRandomValues<T>(n: Int, from array: inout [T]) -> [T] {
        var result = [T]()
        
        for _ in 0..<n {
            if let randomIndex = array.indices.randomElement() {
                result.append(array[randomIndex])
                array.remove(at: randomIndex)
            }
        }
        
        return result
    }
}

struct TeamsView: View {
    var vm: TeamsViewModel
    
    init(vm: TeamsViewModel) {
        self.vm = vm
    }
    
    private var shapes = [AnyShape(CloudShape()), AnyShape(PentagonView())]
    
    var body: some View {
        let members = vm.assignMembersToTeams()
        return VStack {
            ForEach(members.sorted(by: { $0.key < $1.key }), id: \.key) { value in
                VStack {
                    HStack {
                        ForEach(value.value, id: \.id) { member in
                            switch value.key {
                            case 0:
                                Image(uiImage: member.image ?? UIImage())
                                    .resizable()
                                    .clipShape(shapes[0])
                                    .frame(100, 100)
                            case 1:
                                Image(uiImage: member.image ?? UIImage())
                                    .resizable()
                                    .clipShape(shapes[1])
                                    .frame(100, 100)
                            default:
                                Image(uiImage: member.image ?? UIImage())
                                    .resizable()
                                    .clipShape(Rectangle())
                                    .frame(100, 100)
                            }
                        }
                    }
                    if value.key != members.keys.count - 1 {
                        Text("VS")
                            .font(.system(size: 40, weight: .heavy))
                    }
                }
            }
        }
    }
    
//    var body: some View {
//
//        HStack {
//            Image("test_1")
//                .resizable()
//                .clipShape(CloudShape())
//                .frame(100, 100)
//            Image("test_1")
//                .resizable()
//                .clipShape(CloudShape())
//                .frame(100, 100)
//        }
//        HStack {
//            Image("test_1")
//                .resizable()
//                .clipShape(CloudShape())
//                .frame(100, 100)
//            Image("test_1")
//                .resizable()
//                .clipShape(CloudShape())
//                .frame(100, 100)
//        }
//        Text("VS")
//            .font(.system(size: 40, weight: .heavy))
//        HStack {
//            Image("test_2")
//                .resizable()
//                .clipShape(PentagonView())
//                .frame(100, 100)
//            Image("test_2")
//                .resizable()
//                .clipShape(PentagonView())
//                .frame(100, 100)
//        }
//        HStack {
//            Image("test_2")
//                .resizable()
//                .clipShape(PentagonView())
//                .frame(100, 100)
//            Image("test_2")
//                .resizable()
//                .clipShape(PentagonView())
//                .frame(100, 100)
//        }
//        Spacer()
//        Divider()
//            .frame(width: UIScreen.main.width, height: 1)
//            .overlay(.black).shadow(color: .gray, radius: 2, x: 0, y: 2)
//        HStack {
//            Text("Goalkeeper:")
//            Image("test_3")
//                .resizable()
//                .clipShape(PentagonView())
//                .frame(100, 100)
//            Image("test_3")
//                .resizable()
//                .clipShape(CloudShape())
//                .frame(100, 100)
//        }
//        Spacer()
//    }
}

//struct TeamsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamsView()
//    }
//}
