//
//  ProductViewModel.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import Foundation

protocol ProductViewModelable: AlertPresentableViewModel {
    associatedtype GenericPickerDataModel = ProductCategory
    
    var alertModel:  Observable<AlertModel?>       { get set }
    var isLoading:   Observable<Bool>              { get set }
    var productDomainModel: DomainProduct?         { get set }
    
    func setupPickerView(presenter: GenericPickerPresentorable)
}

class ProductViewModel: ProductViewModelable {
    typealias GenericPickerDataModel = ProductCategory
    
    var alertModel:  Observable<AlertModel?> = Observable(nil)
    var isLoading:   Observable<Bool>        = Observable(false)
    var productDomainModel: DomainProduct?
    
    private var pickerViewManager: GenericPickerManager<GenericPickerDataModel>?
    
    init(domainProduct: DomainProduct) {
        productDomainModel = domainProduct
    }
    
    func setupPickerView(presenter: GenericPickerPresentorable) {
        pickerViewManager = GenericPickerManager(with: generateCategories(), presentor: presenter, delegate: self)
    }
    
    private func generateCategories() -> [GenericRow<GenericPickerDataModel>] {
        GenericPickerDataModel.allCases.map({GenericRow(type: $0, title: $0.descriptionTitle)})
    }
}

extension ProductViewModel: GenericPickerManagerDelegate {
    func genericPickerManagerDidSelect(item: Any) {
        guard let item = item as? GenericRow<GenericPickerDataModel> else { return }
        productDomainModel?.category = item.type
    }
}
