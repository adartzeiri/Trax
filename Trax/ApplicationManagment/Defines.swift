//
//  Defines.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import Foundation

let kEmptyString = String()

//  MARK: - GLOBAL functions - localized string
func localized(key: String) -> String
{
    return NSLocalizedString(key, comment: kEmptyString)
}
