//
//  View+Modifiers.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 03.05.2023.
//

import SwiftUI

extension View {
    
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
         if conditional {
             return AnyView(content(self))
         } else {
             return AnyView(self)
         }
     }
    
}

