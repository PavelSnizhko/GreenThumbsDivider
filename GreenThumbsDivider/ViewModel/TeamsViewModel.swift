//
//  TeamsViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 27.04.2023.
//

import SwiftUI

typealias Teams = (goalkeepers: [Int: MemberModel], teamMembers: [Int: [MemberModel]])

final class TeamsViewModel {
    var members: [MemberModel]
    let teamCount: Int
    let goalkeeperCount: Int
    
    lazy var teams: Teams = {
        self.assignMembersToTeams()
    }()
    
    lazy var sortedTeamMembers = teams.teamMembers.sorted(by: { $0.key < $1.key })
    
    lazy var teamsAndShapes = Array(zip(sortedTeamMembers, shapes.shuffled()))
    
    var shapes = [AnyShape(CloudShape()), AnyShape(PentagonView())]
    
    init(members: [MemberModel], teamCount: Int, goalkeeperCount: Int) {
        self.members = members
        self.teamCount = teamCount
        self.goalkeeperCount = goalkeeperCount
    }
    
    private func getGoalkeepers() -> [Int: MemberModel] {
        self.members.shuffle()
        
        var goalkeepers = [Int: MemberModel]()
        
        guard goalkeeperCount > 0, goalkeeperCount <= teamCount, !members.isEmpty else {
            return [:]
        }
        
        if goalkeeperCount == 1 {
            return [0: members.removeFirst()]
        }
        
        for i in 0..<goalkeeperCount {
            goalkeepers[i] = self.members.removeFirst()
        }
        
        return goalkeepers
    }
    
    func assignMembersToTeams() -> Teams {
        let goalkeepers = self.getGoalkeepers()
        
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
        
        return Teams(goalkeepers: goalkeepers, teamMembers: teams)
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
