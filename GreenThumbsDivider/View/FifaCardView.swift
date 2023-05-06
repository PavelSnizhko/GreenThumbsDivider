//
//  FifaCardView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 04.05.2023.
//

import SwiftUI

struct FifaCardViewModel {
    let model: Player
    
    var nickname: String {
        model.nickName.uppercased()
    }

    var skills: [String] {
        model.skills.map { skill in
            skill.concatenatedDesciption
        }
    }
    
    var countryImage: UIImage {
        model.country
    }
    
    var telent: Int {
        model.skills.map(\.number).reduce(0, +) / model.skills.count
    }
    
    var position: String {
        model.playerPosition.abbreviation.uppercased()
    }
    
    var showTape: Bool {
        model.isGoalkeeper
    }
    
}

struct FifaCardView: View {
    let vm: FifaCardViewModel
    
    var body: some View {
        ZStack {
            FifaCardShape()
                .frame(width: 200, height: 300)
            VStack(spacing: 10)  {
                headSection
                bottomSection
            }
            if vm.showTape  {
                TapeView(text: "GK")
            }
        }
    }
    
}

extension FifaCardView {
    var headSection: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(spacing: 5) {
                    Text("\(vm.telent)")
                    Text(vm.position)
                        .underline()
                    VStack(spacing: 0) {
                        Image(uiImage: vm.countryImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 30)
                        Color.white.frame(width: 20, height: 1)
                    }
                    if let image = vm.model.club {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 30)
//                        Image(systemName: "soccerball")
                    }
                }
                .foregroundColor(.white)
                if let image = vm.model.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .offset(x: 10)
                }
            }
            Color.white.frame(width: 200, height: 1)
        }
    }
}

extension FifaCardView {
    var bottomSection: some View {
        VStack(spacing: 6) {
            Text(vm.nickname)
            Color.white.frame(width: 120, height: 1)
            HStack {
                VStack(spacing: 5) {
                    ForEach(vm.skills.prefix(vm.skills.count / 2), id: \.self) { skill in
                        Text(skill)
                    }
                }
                Color.white.frame(width: 1, height: 60)
                VStack(spacing: 5) {
                    ForEach(vm.skills.suffix(vm.skills.count / 2), id: \.self) { skill in
                        Text(skill)
                    }
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct RingShape: Shape {
    
    var currentPercentage: Double
    var thickness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(
            center: CGPoint(x: rect.width / 2, y: rect.height / 2),
            radius: rect.width / 2 - thickness,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360 * currentPercentage),
            clockwise: false
        )
        
        return path
            .strokedPath(.init(lineWidth: thickness, lineCap: .round, lineJoin: .round))
    }
}

struct FifaCardView_Previews: PreviewProvider {
    static var previews: some View {
        FifaCardView(vm: FifaCardViewModel(model: Player(id: UUID(), name: "Paulo", nickName: "Snizhko", image: UIImage(named: "test_2")!, country: UIImage(named: "Ukraine")!, playerPosition: .forward)))
    }
}


struct TapeView: View {
    let text: String
    
    var body: some View {
        ZStack {
            TapeShape()
                .frame(width: 74, height: 125)
                .foregroundColor(.red)
                .offset(x: 63, y: -85)
            Text(text)
                .foregroundColor(.white)
                .rotationEffect(.degrees(60), anchor: .center)
                .offset(x: 72, y: -90)
        }
    }
}
