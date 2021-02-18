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
    var productCategoryCode: Observable<String?>   { get set }
    var productCategory:     Observable<ProductCategory?> { get set }
    var productName:     String?  { get set }
    var productBarcode:  String?  { get set }
    var productImage:    Data?    { get set }
    
    func setupPickerView(presenter: GenericPickerPresentorable)
    func didTapOnCategoryPicker()
    func didChangeName(_ name: String)
    func didSelectImage(image: Data)
    func didScanBarcode(code: String)
    func didTapSubmit() -> DomainProduct
}

class ProductViewModel: ProductViewModelable {
    typealias GenericPickerDataModel = ProductCategory
    
    // MARK: Observables
    var alertModel:  Observable<AlertModel?> = Observable(nil)
    var isLoading:   Observable<Bool>        = Observable(false)
    var productCategoryCode: Observable<String?> = Observable(nil)
    var productCategory:     Observable<ProductCategory?> = Observable(nil)
    var productName:     String?
    var productBarcode:  String?
    var productImage:    Data?
    
    // MARK: Properties
    var productDomainModel: DomainProduct?
    
    // MARK: PickerManager
    private var pickerViewManager: GenericPickerManager<GenericPickerDataModel>?
    
    init(domainProduct: DomainProduct? = nil) {
        productDomainModel = domainProduct
    }
    
    func setupPickerView(presenter: GenericPickerPresentorable) {
        pickerViewManager = GenericPickerManager(with: generateCategoriesForPickerView(), presentor: presenter, delegate: self)
    }
    
    func didTapOnCategoryPicker() {
        pickerViewManager?.showPicker()
    }
    
    func didChangeName(_ name: String) {
        productDomainModel?.name = name
        productName = name
    }
    
    func didSelectImage(image: Data) {
        productImage = image
        productDomainModel?.image = image
    }
    
    func didScanBarcode(code: String) {
        productBarcode = code
        productDomainModel?.barcode = code
    }
    
    func didTapSubmit() -> DomainProduct {
        if let product = productDomainModel {
            return product
        } else {
            return DomainProduct(identfier: Date().timeIntervalSince1970.description, name: productName ?? "", barcode: productBarcode ?? "", category: productCategory.value ?? .general, image: productImage ?? Data())
        }
    }
    
    private func generateCategoriesForPickerView() -> [GenericRow<GenericPickerDataModel>] {
        GenericPickerDataModel.allCases.map({GenericRow(type: $0, title: $0.descriptionTitle)})
    }
}

extension ProductViewModel: GenericPickerManagerDelegate {
    func genericPickerManagerDidSelect(item: Any) {
        guard let item = item as? GenericRow<GenericPickerDataModel> else { return }
        productDomainModel?.category = item.type
        productCategoryCode.value = item.title
        productCategory.value = item.type
    }
}
