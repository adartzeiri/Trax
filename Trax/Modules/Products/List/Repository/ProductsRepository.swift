//
//  ProductsRepository.swift
//  Trax
//
//  Created by Adar Tzeiri on 17/02/2021.
//

import Foundation

protocol ProductRepository {
    typealias DomainModel = DomainProduct
    func getAll() -> [DomainModel]?
    func create( domain: DomainModel )
    func update( domain: DomainModel )
    func delete( domainModel: DomainModel )
}





