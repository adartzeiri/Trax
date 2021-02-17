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
    var categories:  [GenericRow<GenericPickerDataModel>] { get set }
    var name:        String?                       { get set }
    var barcode:     String?                       { get set }
    var imageBase64: String?                       { get set }
    var category:    String?                       { get set }
    
    func setupPickerView(presenter: GenericPickerPresentorable)
}

class ProductViewModel: ProductViewModelable {
    typealias GenericPickerDataModel = ProductCategory
    var name:        String?
    var barcode:     String?
    var imageBase64: String?
    var category:    String?
    
    var pickerViewManager: GenericPickerManager<GenericPickerDataModel>?
    var alertModel:  Observable<AlertModel?> = Observable(nil)
    var isLoading:   Observable<Bool>        = Observable(false)
    var categories:  [GenericRow<GenericPickerDataModel>] = [GenericRow<GenericPickerDataModel>]()
    
    func setupPickerView(presenter: GenericPickerPresentorable) {
        pickerViewManager = GenericPickerManager(with: generateCategories(), presentor: presenter, delegate: self)
    }
    
    private func generateCategories() -> [GenericRow<GenericPickerDataModel>] {
        GenericPickerDataModel.allCases.map({GenericRow(type: $0, title: $0.descriptionTitle)})
    }
}

extension ProductViewModel: GenericPickerManagerDelegate {
    func genericPickerManagerDidSelect(item: Any) {
        //guard let item = item as? GenericRow<GenericPickerDataModel> else { return }
        //selectedCategory.value = item.type
    }
}
