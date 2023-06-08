//
//  DeviceScreenSize.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 08.06.2023.
//

import Foundation

enum DeviceScreenSize {
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXR
    case iPhoneXS
    case iPhoneXSMax
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    case iPhoneSE2
    case iPhone12Mini
    case iPhone12
    case iPhone12Pro
    case iPhone12ProMax
    
    var screenWidth: CGFloat {
        switch self {
        case .iPhoneSE, .iPhone8, .iPhoneSE2:
            return 320
        case .iPhone8Plus, .iPhoneXR, .iPhone11:
            return 414
        case .iPhoneX, .iPhoneXS, .iPhone11Pro, .iPhone12Mini:
            return 375
        case .iPhoneXSMax, .iPhone11ProMax, .iPhone12, .iPhone12Pro:
            return 428
        case .iPhone12ProMax:
            return 428
        }
    }
    
    var screenHeight: CGFloat {
        switch self {
        case .iPhoneSE, .iPhoneSE2:
            return 568
        case .iPhone8:
            return 667
        case .iPhone8Plus:
            return 736
        case .iPhoneX, .iPhoneXS, .iPhone11Pro, .iPhone12Mini:
            return 812
        case .iPhoneXR, .iPhone11:
            return 896
        case .iPhoneXSMax, .iPhone11ProMax, .iPhone12, .iPhone12Pro:
            return 926
        case .iPhone12ProMax:
            return 1284
        }
    }
}
