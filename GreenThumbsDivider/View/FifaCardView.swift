//
//  FifaCardView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 04.05.2023.
//

import SwiftUI

struct FifaCardView: View {    
    var body: some View {
        ZStack {
            FifaCardShape()
                .frame(width: 200, height: 300)
            VStack(spacing: 10)  {
                headSection
                bottomSection
            }
        }
    }
    
}

extension FifaCardView {
    var headSection: some View {
        VStack(spacing: 10) {
            HStack {
                VStack {
                    Text("88")
                    Text("ST")
                        .underline()
                    VStack(spacing: 0) {
                        Image(systemName: "flag.fill")
                        Color.white.frame(width: 20, height: 1)
                    }
                    Image(systemName: "soccerball")
                }
                .foregroundColor(.white)
                Image(uiImage: UIImage(named: "test_1")!)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .offset(x: 15)
            }
            Color.white.frame(width: 200, height: 1)
        }
    }
}

extension FifaCardView {
    var bottomSection: some View {
        VStack(spacing: 6) {
            Text("Snizhko".uppercased())
            Color.white.frame(width: 120, height: 1)
            HStack {
                VStack(spacing: 5) {
                    Text("84 Pac")
                    Text("84 Sho")
                    Text("84 Pas")
                }
                Color.white.frame(width: 1, height: 60)
                VStack(spacing: 5) {
                    Text("84 Dri")
                    Text("84 Def")
                    Text("84 Phy")
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct FifaCardView_Previews: PreviewProvider {
    static var previews: some View {
        FifaCardView()
    }
}

