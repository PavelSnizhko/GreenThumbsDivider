//
//  GameView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 17.05.2023.
//

import SwiftUI

struct GameView: View { 
    var body: some View {
        VStack {
            GameScoreView()
            TimerView()
        }
        .background(.black)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
