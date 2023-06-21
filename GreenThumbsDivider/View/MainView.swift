//
//  MainView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 08.06.2023.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    private let playFlow: (TeamsViewModel) -> Void
    private let playerViewModel: PlayerViewModel
    
    @State private var selectedTab: Int = 0
    
    private let tabs: [Tab] = [.init(icon: Image(systemName: "person.fill"), title: "Players"),
                               .init(icon: Image(systemName: "person.3.fill"), title: "Teams"),
                               .init(icon: Image(systemName: "star.fill"), title: "Stat")]
    
    var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "004ff9"), Color(hex: "fff94c")]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .ignoresSafeArea()
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        Tabs(tabs: tabs, geoWidth: geo.size.width - 32, selectedTab: $selectedTab)
                            .padding([.top, .bottom, .leading, .trailing], 16)
                        TabView(selection: $selectedTab) {
                            SplitTeamView(playerViewModel: playerViewModel, playFlow: playFlow)
                                .tag(0)
                            TeamView(teamViewModel: TeamViewModel(managedObjectContext: managedObjectContext))
                                .tag(1)
                            StatisticsView()
                                .tag(2)
                        }
                    }
                }
            }
    }
    
    init(playerViewModel: PlayerViewModel, playFlow: @escaping (TeamsViewModel) -> Void) {
        self.playerViewModel = playerViewModel
        self.playFlow = playFlow
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground() // <- HERE
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.accentColor)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(Color.accentColor)]
        UITabBar.appearance().standardAppearance = appearance
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(playerViewModel: PlayerViewModel(context: PersistenceController.shared.container.viewContext), playFlow: { _ in })
    }
}
