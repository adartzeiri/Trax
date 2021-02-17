//
//  AlertPresentableViewModel.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import Foundation

protocol AlertPresentableViewModel {
    var alertModel: Observable<AlertModel?> { get set }
}
