//
//  GenericDataSource.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import Foundation

class GenericDataSource<T>: NSObject {
    var data : Observable<[T]> = Observable([])
}
