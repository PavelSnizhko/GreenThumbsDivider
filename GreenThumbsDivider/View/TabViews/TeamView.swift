//
//  TeamView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 08.06.2023.
//

import SwiftUI
import CoreData
import Combine

struct TeamView: View {
    @StateObject private var teamViewModel: TeamViewModel
    
    init(teamViewModel: TeamViewModel) {
        self._teamViewModel = .init(wrappedValue: teamViewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "004ff9"), Color(hex: "fff94c")]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .ignoresSafeArea()
                List {
                    ForEach(teamViewModel.teams) { team in
                        VStack(alignment: .leading) {
                            Image(uiImage: team.icon)
                            Text(team.name)
                        }
                    }
                    .onDelete(perform: teamViewModel.delete)
                    .listStyle(DefaultListStyle())
                }
                .scrollContentBackground(.hidden)
            }
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
    private var cancellables: Set<AnyCancellable> = []
    
    private let manager: TeamStorage
    
    @Published var teams: [TeamModel] = []
    private var cancellable: AnyCancellable?
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.manager = TeamStorage.shared
        cancellable = manager.teams
            .eraseToAnyPublisher()
            .sink(receiveValue: { [unowned self] teams in
                self.teams = teams
            })
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let team = teams[index]
            manager.delete(id: team.id)
        }
    }
}
