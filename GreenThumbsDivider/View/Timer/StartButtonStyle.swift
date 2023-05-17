//
//  StartButtonStyle.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 17.05.2023.
//

import SwiftUI

struct CircleButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: 70)
            .foregroundColor(color)
            .background(color.opacity(0.3))
            .clipShape(Circle())
            .padding(.all, 3)
            .overlay(Circle()
                .stroke(color.opacity(0.3), lineWidth: 2))
    }
}
