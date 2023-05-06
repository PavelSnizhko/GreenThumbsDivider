//
//  TeamsViewModel.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 27.04.2023.
//

import SwiftUI

typealias Teams = [Int: [Player]]

final class TeamsViewModel {
    var members: [Player]
    let teamCount: Int
    let goalkeeperCount: Int
    
    lazy var teams: Teams = {
        self.assignMembersToTeams()
    }()
    
    init(members: [Player], teamCount: Int, goalkeeperCount: Int) {
        self.members = members
        self.teamCount = teamCount
        self.goalkeeperCount = goalkeeperCount
    }
    
    private func selectGoalkeepers() -> [Player] {
        var goalkeeprs: [Player] = []
        guard goalkeeperCount > 0,
              goalkeeperCount <= teamCount,
              !members.isEmpty else {
            return goalkeeprs
        }
        
        self.members.shuffle()
        
        for i in 0..<goalkeeperCount {
            var player = self.members.remove(at: i)
            player.isGoalkeeper = true
            goalkeeprs.append(player)
        }
        
        return goalkeeprs
    }
    
    func assignMembersToTeams() -> [Int: [Player]] {
        var goalkeepers = selectGoalkeepers()
        
        var teams = [Int: [Player]]()
        let totalMembers = members.count
        let membersPerTeam = totalMembers / teamCount
        var extraMembers = totalMembers % teamCount
        
        // Shuffle the members array randomly
        var shuffledMembers = members.shuffled()
        
        // Assign members to each team
        for i in 0..<teamCount {
            var membersForTeam = [Player]()
            
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
        
        teams.sorted { $0.value.count < $1.value.count }.forEach { team in
            guard goalkeepers.count > 0 else {
                return
            }
            
            var players = team.value
            players.append(goalkeepers.removeFirst())
            teams[team.key] = players
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
