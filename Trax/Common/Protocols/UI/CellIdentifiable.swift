//
//  CellIdentifiable.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

protocol CellIdentifiable {
    static var cellID  : String { get }
    static var cellNib : UINib  { get }
}

extension CellIdentifiable {
    static var cellID : String {
        return String(describing: Self.self)
    }
    
    static var cellNib : UINib {
        return UINib(nibName: cellID, bundle: nil)
    }
}
