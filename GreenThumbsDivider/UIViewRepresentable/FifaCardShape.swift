//
//  FifaCardShape.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 04.05.2023.
//

import SwiftUI

struct FifaCardShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.86748*width, y: 0.05203*height))
        path.addCurve(to: CGPoint(x: 0.86541*width, y: 0.04595*height), control1: CGPoint(x: 0.86697*width, y: 0.04872*height), control2: CGPoint(x: 0.86672*width, y: 0.04706*height))
        path.addCurve(to: CGPoint(x: 0.85741*width, y: 0.04318*height), control1: CGPoint(x: 0.86409*width, y: 0.04485*height), control2: CGPoint(x: 0.86186*width, y: 0.04429*height))
        path.addCurve(to: CGPoint(x: 0.49833*width, y: 0), control1: CGPoint(x: 0.74633*width, y: 0.01532*height), control2: CGPoint(x: 0.62517*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.13924*width, y: 0.04318*height), control1: CGPoint(x: 0.37148*width, y: 0), control2: CGPoint(x: 0.25031*width, y: 0.01532*height))
        path.addCurve(to: CGPoint(x: 0.13124*width, y: 0.04595*height), control1: CGPoint(x: 0.13479*width, y: 0.04429*height), control2: CGPoint(x: 0.13256*width, y: 0.04485*height))
        path.addCurve(to: CGPoint(x: 0.12917*width, y: 0.05203*height), control1: CGPoint(x: 0.12993*width, y: 0.04706*height), control2: CGPoint(x: 0.12968*width, y: 0.04872*height))
        path.addCurve(to: CGPoint(x: 0.01554*width, y: 0.12524*height), control1: CGPoint(x: 0.12334*width, y: 0.09021*height), control2: CGPoint(x: 0.07578*width, y: 0.12071*height))
        path.addCurve(to: CGPoint(x: 0.00196*width, y: 0.1275*height), control1: CGPoint(x: 0.0078*width, y: 0.12582*height), control2: CGPoint(x: 0.00393*width, y: 0.12611*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.13562*height), control1: CGPoint(x: 0, y: 0.12889*height), control2: CGPoint(x: 0, y: 0.13114*height))
        path.addLine(to: CGPoint(x: 0, y: 0.77919*height))
        path.addCurve(to: CGPoint(x: 0.01821*width, y: 0.85933*height), control1: CGPoint(x: 0, y: 0.82224*height), control2: CGPoint(x: 0, y: 0.84377*height))
        path.addCurve(to: CGPoint(x: 0.13726*width, y: 0.89459*height), control1: CGPoint(x: 0.03642*width, y: 0.87489*height), control2: CGPoint(x: 0.07003*width, y: 0.88146*height))
        path.addCurve(to: CGPoint(x: 0.49833*width, y: height), control1: CGPoint(x: 0.28183*width, y: 0.92283*height), control2: CGPoint(x: 0.48989*width, y: 0.96866*height))
        path.addCurve(to: CGPoint(x: 0.85939*width, y: 0.89459*height), control1: CGPoint(x: 0.50676*width, y: 0.96866*height), control2: CGPoint(x: 0.71482*width, y: 0.92283*height))
        path.addCurve(to: CGPoint(x: 0.97844*width, y: 0.85933*height), control1: CGPoint(x: 0.92661*width, y: 0.88146*height), control2: CGPoint(x: 0.96022*width, y: 0.87489*height))
        path.addCurve(to: CGPoint(x: 0.99665*width, y: 0.77919*height), control1: CGPoint(x: 0.99665*width, y: 0.84377*height), control2: CGPoint(x: 0.99665*width, y: 0.82224*height))
        path.addLine(to: CGPoint(x: 0.99665*width, y: 0.13562*height))
        path.addCurve(to: CGPoint(x: 0.99468*width, y: 0.1275*height), control1: CGPoint(x: 0.99665*width, y: 0.13114*height), control2: CGPoint(x: 0.99665*width, y: 0.12889*height))
        path.addCurve(to: CGPoint(x: 0.98111*width, y: 0.12524*height), control1: CGPoint(x: 0.99272*width, y: 0.12611*height), control2: CGPoint(x: 0.98885*width, y: 0.12582*height))
        path.addCurve(to: CGPoint(x: 0.86748*width, y: 0.05203*height), control1: CGPoint(x: 0.92087*width, y: 0.12071*height), control2: CGPoint(x: 0.87331*width, y: 0.09021*height))
        path.closeSubpath()
        return path
    }
}
