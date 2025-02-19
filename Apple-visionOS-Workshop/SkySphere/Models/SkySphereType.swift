//
//  SkySphereType.swift
//  Apple-visionOS-Workshop
//
//  Created by Ricky on 2025/2/14.
//

import Foundation

enum SkySphereType: CaseIterable {
    case basementParking
    case clearNight
    case colorfulHouse
    case sky
    case barn
    case beach
    case galaxy
    case midnightPalace
    case restaurant
    case street
}

extension SkySphereType {
    
    var title: String {
        switch self {
        case .basementParking:
            return "地下停車場"
        case .clearNight:
            return "晴朗夜空"
        case .colorfulHouse:
            return "繽紛小屋"
        case .sky:
            return "廣闊天空"
        case .barn:
            return "鄉村穀倉"
        case .beach:
            return "靜謐海灘"
        case .galaxy:
            return "璀璨銀河"
        case .midnightPalace:
            return "午夜宮殿"
        case .restaurant:
            return "溫馨餐廳"
        case .street:
            return "繁華街道"
        }
    }

    
    var environmentImageName: String {
        switch self {
        case .basementParking:
            return "basement_parking"
        case .clearNight:
            return "clear_night"
        case .colorfulHouse:
            return "colorful_house"
        case .sky:
            return "sky"
        case .barn:
            return "barn"
        case .beach:
            return "beach"
        case .galaxy:
            return "galaxy"
        case .midnightPalace:
            return "midnight_palace"
        case .restaurant:
            return "restaurant"
        case .street:
            return "street"
        }
    }
    
    var hdriImageName: String {
        self.environmentImageName + "_hdri"
    }
    
    var hasHDRI: Bool {
        switch self {
        case .basementParking, .clearNight, .colorfulHouse, .sky:
            return true
        default:
            return false
        }
    }
}
