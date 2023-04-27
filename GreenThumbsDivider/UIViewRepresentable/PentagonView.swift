//
//  PentagonView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 24.04.2023.
//

import SwiftUI

struct PentagonView: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: 0.50009*width, y: 0.00952*height))
        path.addLine(to: CGPoint(x: 0.98919*width, y: 0.25778*height))
        path.addLine(to: CGPoint(x: 0.98919*width, y: 0.70952*height))
        path.addLine(to: CGPoint(x: 0.50009*width, y: 0.98571*height))
        path.addLine(to: CGPoint(x: 0.01099*width, y: 0.70952*height))
        path.addLine(to: CGPoint(x: 0.01099*width, y: 0.25778*height))
        path.addLine(to: CGPoint(x: 0.50009*width, y: 0.00952*height))
        path.closeSubpath()
        
        return path
    }
    
}
