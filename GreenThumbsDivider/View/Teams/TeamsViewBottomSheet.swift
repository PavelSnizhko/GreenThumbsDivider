//
//  TeamsViewBottomSheet.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 09.06.2023.
//

import SwiftUI
import CoreData

class TeamsViewBottomSheetViewModel: ObservableObject {
    @Published var teamName: String = ""
    
    private let manager: TeamStorage
    private let manageObjectContext: NSManagedObjectContext
    
    var selectedPlayers: [PlayerModel] = []
    
    let teamMembers: [PlayerModel]
    
    init(teamMembers: [PlayerModel], manageObjectContext: NSManagedObjectContext) {
        self.teamMembers = teamMembers
        self.manageObjectContext = manageObjectContext
        self.manager = TeamStorage.shared
    }
    
    func saveTeams() {
        let players = teamMembers.compactMap { playerModel in
            try? Player.findOrCreate(playerModel, context: manageObjectContext)
        }
        
        manager.createTeam(teamName: teamName, players: players)
    }

}

struct TeamsViewBottomSheet: View {
    @Binding var isPresented: Bool
    @StateObject var vm: TeamsViewBottomSheetViewModel


    init(isPresented: Binding<Bool>,
        vm: TeamsViewBottomSheetViewModel) {
        self._isPresented = isPresented
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(10)
                TextField("Team name", text: $vm.teamName)
                    .font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                    .foregroundColor(.green)
                
            }
            .padding(20)
            .background(.yellow)
            .cornerRadius(20)
            .shadow(radius: 10)
            
            Button(action: {
                vm.saveTeams()
                isPresented.toggle()
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding([.leading, .trailing], 45)
                    .padding([.top, .bottom], 15)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding([.leading, .trailing], 50)
    }
}

struct TeamsViewBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        TeamsViewBottomSheet(isPresented: .constant(true),
                             vm: TeamsViewBottomSheetViewModel(teamMembers: [], manageObjectContext: PersistenceController.shared.container.viewContext))
    }
}
