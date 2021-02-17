//
//  Storyboarded.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

enum Storyboard : String {
    case ProductList
    case ProductDetails
}

protocol Storyboarded {
    static var storyboardID: Storyboard { get set }
    static func instantiate() -> Self
}

extension Storyboarded where Self : UIViewController {
    
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: Self.storyboardID.rawValue, bundle: nil)
        
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}
