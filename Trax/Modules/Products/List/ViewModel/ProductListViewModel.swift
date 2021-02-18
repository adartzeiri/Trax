//
//  ProductListViewModel.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import Foundation

protocol ProductListViewModelable: AlertPresentableViewModel {
    var dataSource: ProductListTableDataSource    { get }
    var repository: ProductRepository?            { get }
    var alertModel: Observable<AlertModel?>       { get set }
    var isLoading: Observable<Bool>               { get set }
    
    func fetch()
    func create(product: DomainProduct)
    func delete(product: DomainProduct)
    func update(product: DomainProduct)
}

class ProductListViewModel: ProductListViewModelable {
    var repository: ProductRepository?
    var alertModel: Observable<AlertModel?> = Observable(nil)
    var dataSource: ProductListTableDataSource = ProductListTableDataSource()
    var isLoading: Observable<Bool> = Observable(true)
    
    convenience init(repository: ProductRepository) {
        self.init()
        self.repository = repository
        dataSource.delegate = self
    }
    
    private func getProductsByCategories(products: [DomainProduct]) -> [[DomainProduct]] {
        var domainProducts = [[DomainProduct]]()
        for category in ProductCategory.allCases {
            domainProducts.append(sortProductsByName(products: products.filter({$0.category.code == category.code})) ?? [])
        }
        
        return domainProducts
    }

    private func sortProductsByName(products: [DomainProduct]) -> [DomainProduct]? {
        products.sorted { (product1, product2) -> Bool in
            product1.name.lowercased() < product2.name.lowercased()
        }
    }
    
    func fetch() {
        isLoading.value = true
        guard let products = repository?.getAll() else { return }
        dataSource.data.value = getProductsByCategories(products: products)
        isLoading.value = false
    }
    
    func create(product: DomainProduct) {
        repository?.create(domain: product)
        fetch()
    }
    
    func delete(product: DomainProduct) {
        repository?.delete(domainModel: product)
        fetch()
    }
    
    func update(product: DomainProduct) {
        repository?.update(domain: product)
        fetch()
    }
}

extension ProductListViewModel: ProductListTableDataSourceDelegate {
    func deleteItem(item: DomainProduct) {
        delete(product: item)
    }
}
