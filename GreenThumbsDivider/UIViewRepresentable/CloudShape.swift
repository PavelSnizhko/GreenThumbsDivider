//
//  CloudShape.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 21.04.2023.
//

import SwiftUI
import PureSwiftUI

struct CloudShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: 0.09997*width, y: 0.53582*height))
        
        path.addCurve(to: CGPoint(x: 0.11205*width, y: 0.91379*height), control1: CGPoint(x: -0.00166*width, y: 0.64417*height), control2: CGPoint(x: 0.00375*width, y: 0.81339*height))
        path.addCurve(to: CGPoint(x: 0.49215*width, y: 0.8994*height), control1: CGPoint(x: 0.22035*width, y: 1.01419*height), control2: CGPoint(x: 0.39052*width, y: 1.00775*height))
        path.addCurve(to: CGPoint(x: 0.52877*width, y: 0.89836*height), control1: CGPoint(x: 0.50222*width, y: 0.88867*height), control2: CGPoint(x: 0.5182*width, y: 0.88821*height))
        path.addLine(to: CGPoint(x: 0.53068*width, y: 0.9002*height))
        path.addCurve(to: CGPoint(x: 0.90919*width, y: 0.89304*height), control1: CGPoint(x: 0.63686*width, y: 1.00214*height), control2: CGPoint(x: 0.81934*width, y: 0.98555*height))
        path.addCurve(to: CGPoint(x: 0.90318*width, y: 0.51671*height), control1: CGPoint(x: 1.01206*width, y: 0.78714*height), control2: CGPoint(x: 1.00937*width, y: 0.61865*height))
        path.addLine(to: CGPoint(x: 0.89858*width, y: 0.51229*height))
        path.addCurve(to: CGPoint(x: 0.8975*width, y: 0.46725*height), control1: CGPoint(x: 0.88627*width, y: 0.50047*height), control2: CGPoint(x: 0.88577*width, y: 0.47976*height))
        path.addLine(to: CGPoint(x: 0.90003*width, y: 0.46455*height))
        path.addCurve(to: CGPoint(x: 0.88795*width, y: 0.08658*height), control1: CGPoint(x: 1.00166*width, y: 0.3562*height), control2: CGPoint(x: 0.99625*width, y: 0.18698*height))
        path.addCurve(to: CGPoint(x: 0.52305*width, y: 0.10017*height), control1: CGPoint(x: 0.77966*width, y: -0.01382*height), control2: CGPoint(x: 0.62468*width, y: -0.00818*height))
        path.addCurve(to: CGPoint(x: 0.47123*width, y: 0.10201*height), control1: CGPoint(x: 0.51298*width, y: 0.1109*height), control2: CGPoint(x: 0.4818*width, y: 0.11216*height))
        path.addCurve(to: CGPoint(x: 0.09081*width, y: 0.10733*height), control1: CGPoint(x: 0.36505*width, y: 0.00006*height), control2: CGPoint(x: 0.19367*width, y: 0.00143*height))
        path.addCurve(to: CGPoint(x: 0.09682*width, y: 0.48366*height), control1: CGPoint(x: -0.00769*width, y: 0.20873*height), control2: CGPoint(x: -0.00937*width, y: 0.38172*height))
        path.addLine(to: CGPoint(x: 0.10142*width, y: 0.48809*height))
        path.addCurve(to: CGPoint(x: 0.10251*width, y: 0.53312*height), control1: CGPoint(x: 0.11374*width, y: 0.4999*height), control2: CGPoint(x: 0.11423*width, y: 0.52061*height))
        path.addLine(to: CGPoint(x: 0.09997*width, y: 0.53582*height))
        
        path.closeSubpath()
        
        return path
    }
}
