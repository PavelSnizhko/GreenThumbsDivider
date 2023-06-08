//
//  MainView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 08.06.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab: Int = 0
    
    private let tabs: [Tab] = [.init(icon: Image(systemName: "person.fill"), title: "Players"),
                               .init(icon: Image(systemName: "person.3.fill"), title: "Teams"),
                               .init(icon: Image(systemName: "star.fill"), title: "Stat")]
    
    var body: some View {
        NavigationView {
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
                            SplitTeamView()
                                .tag(0)
                            TeamView()
                                .tag(1)
                            StatisticsView()
                                .tag(2)
                        }
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
