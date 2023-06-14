//
//  TeamView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 08.06.2023.
//

import SwiftUI
import CoreData

struct TeamView: View {
    private let teamViewModel: TeamViewModel
    
    init(teamViewModel: TeamViewModel) {
        self.teamViewModel = teamViewModel
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "004ff9"), Color(hex: "fff94c")]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .ignoresSafeArea()
            List {
                ForEach(teamViewModel.teams()) { team in
                    VStack {
                        Text(team.name)
                        Image(uiImage: team.icon)
                    }
                }
                .listStyle(DefaultListStyle())
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(teamViewModel: TeamViewModel(managedObjectContext: PersistenceController.shared.container.viewContext))
    }
}

//TODO: rename to Team but core data models rename to Entities
struct TeamModel {
    let id: UUID
    let name: String
    let icon: UIImage
    let players: [PlayerModel]
}

extension TeamModel: Identifiable {
    
}

class TeamViewModel: ObservableObject {
    private let manager: TeamManagement
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.manager = TeamManager(context: managedObjectContext)
    }
    
    func teams() -> [TeamModel] {
        manager.fetchTeams()
    }
}
