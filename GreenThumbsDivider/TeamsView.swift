//
//  TeamsView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 24.04.2023.
//

import SwiftUI

struct TeamsView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image("test_1")
                    .resizable()
                    .clipShape(CloudShape())
                    .frame(100, 100)
                Image("test_1")
                    .resizable()
                    .clipShape(CloudShape())
                    .frame(100, 100)
            }
            HStack {
                Image("test_1")
                    .resizable()
                    .clipShape(CloudShape())
                    .frame(100, 100)
                Image("test_1")
                    .resizable()
                    .clipShape(CloudShape())
                    .frame(100, 100)
            }
            Text("VS")
                .font(.system(size: 40, weight: .heavy))
            HStack {
                Image("test_2")
                    .resizable()
                    .clipShape(PentagonView())
                    .frame(100, 100)
                Image("test_2")
                    .resizable()
                    .clipShape(PentagonView())
                    .frame(100, 100)
            }
            HStack {
                Image("test_2")
                    .resizable()
                    .clipShape(PentagonView())
                    .frame(100, 100)
                Image("test_2")
                    .resizable()
                    .clipShape(PentagonView())
                    .frame(100, 100)
            }
        }
        Spacer()
        Divider()
            .frame(width: UIScreen.main.width, height: 1)
            .overlay(.black).shadow(color: .gray, radius: 2, x: 0, y: 2)
        HStack {
            Text("Goalkeeper:")
            Image("test_3")
                .resizable()
                .clipShape(PentagonView())
                .frame(100, 100)
            Image("test_3")
                .resizable()
                .clipShape(CloudShape())
                .frame(100, 100)
        }
        Spacer()
    }
    
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}
