//
//  SplittedTeamView.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 12.04.2023.
//

import SwiftUI
import PureSwiftUI

struct SplittedTeamViewModel {
    var firstTeam: [MemberModel] = [MemberModel(id: UUID(), imageName: "test_1", name: "Paulo", nickName: "Messi"),
                                    MemberModel(id: UUID(), imageName: "test_1", name: "Paulo", nickName: "Messi")]
    
    var secondTeam: [MemberModel] = [MemberModel(id: UUID(), imageName: "test_2", name: "Tarik", nickName: "Messi"),
                                     MemberModel(id: UUID(), imageName: "test_3", name: "Tarik", nickName: "Messi")]
    
    
}
