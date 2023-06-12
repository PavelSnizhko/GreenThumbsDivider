//
//  GameScoreView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 17.05.2023.
//

import SwiftUI

typealias TeamInfo = (title: String, emblem: UIImage)

struct Game {
    var teamInfo: [TeamInfo]
    var firstTeamPlayers: [PlayerModel]
    var secondTeamPlayers: [PlayerModel]
}

struct GameResult {
    let result: [String: Int]
    let resultString: String
}

class GameViewModel: ObservableObject {
    @Published var firstTeamGoals: Int = 0
    @Published var secondTeamGoals: Int = 0
    @Published var isGameActive: Bool = false
    
    var game: Game
    
    init(firstTeamGoals: Int = 0, secondTeamGoals: Int = 0, game: Game) {
        self.firstTeamGoals = firstTeamGoals
        self.secondTeamGoals = secondTeamGoals
        self.game = game
    }
    
    var firstTeamEmblem: UIImage {
        game.teamInfo[0].emblem
    }
    
    var firstTeamTitle: String {
        game.teamInfo[0].title
    }
    
    var secondTeamEmblem: UIImage {
        game.teamInfo[1].emblem
    }
    
    var secondTeamTitle: String {
        game.teamInfo[1].title
    }
    
    var result: GameResult {
        let resultString = "\(firstTeamGoals):\(secondTeamGoals)"
        return GameResult(result: [firstTeamTitle: firstTeamGoals, secondTeamTitle: secondTeamGoals], resultString: resultString)
    }
}

struct GameScoreView: View {
    @StateObject private var vm = GameViewModel(game: Game(teamInfo: [
        TeamInfo(title: "Dynamo", emblem: UIImage(named: "Dynamo")!),
        TeamInfo(title: "Shakhtar", emblem: UIImage(named: "Shakhtar")!)], firstTeamPlayers: [], secondTeamPlayers: []))
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Image(uiImage: vm.firstTeamEmblem)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                Text(vm.firstTeamTitle)
            }
            Group {
                Text("\(vm.firstTeamGoals)")
                    .onTapGesture {
                        withAnimation {
                            vm.firstTeamGoals += 1
                        }
                    }
                Text(":")
                Text("\(vm.secondTeamGoals)")
                    .onTapGesture {
                        withAnimation {
                            vm.secondTeamGoals += 1
                        }
                    }
            }
            .font(.system(size: 50, weight: .medium))
            .disabled(!vm.isGameActive)
            VStack(spacing: 0) {
                Image(uiImage: vm.secondTeamEmblem)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                Text(vm.secondTeamTitle)
            }
        }
        .frame(width: 350, height: 200)
        .background(Color.teal)
        .cornerRadius(20)
    }
}

struct GameScoreView_Previews: PreviewProvider {
    static var previews: some View {
        GameScoreView()
    }
}
