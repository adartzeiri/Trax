//
//  ProductCaterogry.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import Foundation

enum ProductCategory: CaseIterable {
    case general
    case sparkling
    case coffee
    case juice
    case sports
    case vitamin_Water
    case energy
    case tea
    case water
    case flavored_Water
    case sparkling_Water
    
    init(_ code: String) {
        switch code {
        case "00": self = .general
        case "01": self = .sparkling
        case "02": self = .coffee
        case "03": self = .juice
        case "04": self = .sports
        case "05": self = .vitamin_Water
        case "06": self = .energy
        case "07": self = .tea
        case "08": self = .water
        case "09": self = .flavored_Water
        case "10": self = .sparkling_Water
        default:   self = .general
        }
    }
    
    var descriptionTitle: String { return "\(code) - \(title)" }
    
    var code: String {
        switch self {
        case .general:         return "00"
        case .sparkling:       return "01"
        case .coffee:          return "02"
        case .juice:           return "03"
        case .sports:          return "04"
        case .vitamin_Water:   return "05"
        case .energy:          return "06"
        case .tea:             return "07"
        case .water:           return "08"
        case .flavored_Water:  return "09"
        case .sparkling_Water: return "10"
        }
    }
    
    var title: String {
        switch self {
        case .general:         return "General"
        case .sparkling:       return "Sparkling"
        case .coffee:          return "Coffee"
        case .juice:           return "Juice"
        case .sports:          return "Sports"
        case .vitamin_Water:   return "Vitamin Water"
        case .energy:          return "Energy"
        case .tea:             return "Tea"
        case .water:           return "Water"
        case .flavored_Water:  return "Flavored Water"
        case .sparkling_Water: return "Sparkling Water"
        }
    }
}
