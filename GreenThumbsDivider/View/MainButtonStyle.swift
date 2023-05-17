//
//  MainButtonStyle.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 17.05.2023.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    let color: Color
    let textColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 50)
            .background(color)
            .foregroundColor(textColor)
            
    }
}
