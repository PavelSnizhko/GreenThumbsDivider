//
//  SkillsSliderView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 05.05.2023.
//

import SwiftUI


struct SkillsSliderView: View {
    
    @ObservedObject var vm: SkillsViewModel
    
    var body: some View {
        
        let binding: (String) -> Binding = { key in
            Binding(
                get: { vm.skills[key] ?? 0.0 },
                set: { vm.skills[key] = $0 }
            )
        }
        
        return HStack {
            VStack {
                ForEach(vm.firstSkillsGroup , id: \.self) { skill in
                    VStack {
                        Text("\(skill.desciption) **\(Int(vm.skills[skill.desciption]!))**")
                        Slider(value: binding(skill.desciption), in: 0...100) {
                                Text("")
                            } minimumValueLabel: {
                                Text("0").font(.title2).fontWeight(.thin)
                            } maximumValueLabel: {
                                Text("100").font(.title2).fontWeight(.thin)
                            }
                    }
                }
            }
            VStack {
                ForEach(vm.secondSkillsGroup , id: \.self) { skill in
                    VStack {
                        Text("\(skill.desciption) **\(Int(vm.skills[skill.desciption]!))**")
                        Slider(value: binding(skill.desciption), in: 0...100) {
                                Text("")
                            } minimumValueLabel: {
                                Text("0").font(.title2).fontWeight(.thin)
                            } maximumValueLabel: {
                                Text("100").font(.title2).fontWeight(.thin)
                            }
                    }
                }
            }
        }
    }
}

struct SkillsSliderView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsSliderView(vm: SkillsViewModel())
    }
}
