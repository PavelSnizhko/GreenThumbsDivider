//
//  TeamsViewBottomSheet.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 09.06.2023.
//

import SwiftUI
import CoreData

class TeamsViewBottomSheetViewModel: ObservableObject {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var firstTeamName: String = ""
    @State var secondTeamName: String = ""
    
    private lazy var manager: TeamManagement = TeamManager(context: managedObjectContext)
    
    let firstTeamMembers: [Member]
    let secondTeamMembers: [Member]
    
    init(firstTeamMembers: [Member], secondTeamMembers: [Member]) {
        self.firstTeamMembers = firstTeamMembers
        self.secondTeamMembers = secondTeamMembers
    }
    
    func saveTeams() {
        manager.createTeam(teamName: firstTeamName, members: firstTeamMembers)
        manager.createTeam(teamName: secondTeamName, members: secondTeamMembers)
    }

}

struct TeamsViewBottomSheet: View {
    @Binding var isPresented: Bool
    @StateObject var vm: TeamsViewBottomSheetViewModel = TeamsViewBottomSheetViewModel(firstTeamMembers: [], secondTeamMembers: [])

    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(10)
                TextField("First team name", text: $vm.firstTeamName)
                    .font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
            }
            .padding(20)
            .background(.green)
            .cornerRadius(20)
            .shadow(radius: 10)

            VStack {
                Image(systemName: "camera.circle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(10)
                TextField("Second team Name", text: $vm.secondTeamName)
                    .font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                
            }
            .padding(20)
            .background(.yellow)
            .cornerRadius(20)
            .shadow(radius: 10)
            
            Button(action: {
                vm.saveTeams()
                // Perform an action with the entered team name
                print("Entered first team name: \(vm.firstTeamName)")
                print("Entered second team name: \(vm.secondTeamName)")
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
        TeamsViewBottomSheet(isPresented: .constant(true))
    }
}
