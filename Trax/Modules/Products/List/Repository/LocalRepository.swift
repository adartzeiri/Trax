//
//  LocalRepository.swift
//  Trax
//
//  Created by Adar Tzeiri on 17/02/2021.
//

import Foundation
import RealmSwift

class LocalProductRepository: ProductRepository {
    var products: Results<RealmProduct>?
    var realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        } catch {
            print(error)
        }
    }
    
    func getAll() -> [DomainModel]? {
        products = realm?.objects(RealmProduct.self)
        return products?.map({ DomainProduct(identfier: $0.identifier, name: $0.name, barcode: $0.barcode, category: ProductCategory($0.category), image: $0.image)})
    }
    
    func create(domain: DomainModel) {
        do {
            try realm?.write({
                realm?.add(RealmProduct(domainModel: domain))
            })
        } catch {
            print(error)
        }
    }
    
    func update(domain: DomainModel) {
        do {
            try realm?.write({
                let product = products?.first(where: {$0.identifier == domain.identfier})
                product?.name     = domain.name
                product?.barcode  = domain.barcode
                product?.image    = domain.image
                product?.category = domain.category.code
            })
        } catch {
            print(error)
        }
    }
    
    func delete(domainModels: [DomainModel]) {
        do {
            try realm?.write({
                realm?.delete(domainModels.map({RealmProduct(domainModel: $0)}))
            })
        } catch {
            print(error)
        }
    }
}

class RealmProduct : Object {
    @objc dynamic var name:       String = ""
    @objc dynamic var barcode:    String = ""
    @objc dynamic var category:   String = ""
    @objc dynamic var identifier: String = ""
    @objc dynamic var image:      Data   = Data()
    
    convenience init(domainModel: DomainProduct) {
        self.init()
        self.name       = domainModel.name
        self.barcode    = domainModel.barcode
        self.category   = domainModel.category.code
        self.identifier = domainModel.identfier
        self.image      = domainModel.image
    }
}


