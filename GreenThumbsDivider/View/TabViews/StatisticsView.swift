//
//  SatisticsView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 08.06.2023.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "004ff9"), Color(hex: "fff94c")]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .ignoresSafeArea()
        }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
