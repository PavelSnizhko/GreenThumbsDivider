//
//  TapeShape.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 06.05.2023.
//

import SwiftUI

struct TapeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.05107*width, y: 0.00592*height))
        path.addLine(to: CGPoint(x: 0.08113*width, y: 0.0074*height))
        path.addLine(to: CGPoint(x: 0.13777*width, y: 0.01109*height))
        path.addLine(to: CGPoint(x: 0.13777*width, y: 0.01109*height))
        path.addLine(to: CGPoint(x: 0.15102*width, y: 0.01205*height))
        path.addLine(to: CGPoint(x: 0.16428*width, y: 0.01309*height))
        path.addLine(to: CGPoint(x: 0.1643*width, y: 0.01309*height))
        path.addLine(to: CGPoint(x: 0.18019*width, y: 0.01442*height))
        path.addLine(to: CGPoint(x: 0.20672*width, y: 0.01685*height))
        path.addLine(to: CGPoint(x: 0.23857*width, y: 0.02003*height))
        path.addLine(to: CGPoint(x: 0.27307*width, y: 0.0238*height))
        path.addLine(to: CGPoint(x: 0.30757*width, y: 0.02794*height))
        path.addLine(to: CGPoint(x: 0.33942*width, y: 0.03208*height))
        path.addLine(to: CGPoint(x: 0.33945*width, y: 0.03209*height))
        path.addLine(to: CGPoint(x: 0.36912*width, y: 0.03622*height))
        path.addLine(to: CGPoint(x: 0.98936*width, y: 0.6937*height))
        path.addLine(to: CGPoint(x: 0.98936*width, y: 0.98448*height))
        path.addLine(to: CGPoint(x: 0.01057*width, y: 0.0041*height))
        path.addLine(to: CGPoint(x: 0.01566*width, y: 0.00429*height))
        path.addLine(to: CGPoint(x: 0.02625*width, y: 0.00473*height))
        path.addLine(to: CGPoint(x: 0.05106*width, y: 0.00592*height))
        path.addLine(to: CGPoint(x: 0.05107*width, y: 0.00592*height))
        path.closeSubpath()
        return path
    }
}
