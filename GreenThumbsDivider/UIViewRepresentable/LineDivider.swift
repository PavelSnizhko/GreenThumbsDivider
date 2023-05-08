//
//  LineDivider.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 08.05.2023.
//

import SwiftUI

struct LineDivider: View {
    let text: String
    let lineColor: Color
    
    var body: some View {
        HStack {
            lineColor.frame(height: 2)
                .padding(.leading, 20)
            Text(text)
                .font(.system(size: 20, weight: .heavy))
            lineColor.frame(height: 2)
                .padding(.trailing, 20)
        }
    }
}
