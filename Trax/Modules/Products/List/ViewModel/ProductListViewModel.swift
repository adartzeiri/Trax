//
//  ProductListViewModel.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import Foundation

protocol ProductListViewModelable: AlertPresentableViewModel {
    var dataSource: ProductListTableDataSource    { get }
    //var networkManager: NetworkManager<EndPoint>? { get }
    var alertModel: Observable<AlertModel?>       { get set }
    var productViewModels: [ProductViewModel]     { get set }
    var isLoading: Observable<Bool>               { get set }
    
    func fetchProducts()
}

class ProductListViewModel: ProductListViewModelable {
    //var networkManager: NetworkManager<EndPoint>?
    var alertModel: Observable<AlertModel?> = Observable(nil)
    var dataSource: ProductListTableDataSource = ProductListTableDataSource()
    var productViewModels: [ProductViewModel] = []
    var isLoading: Observable<Bool> = Observable(true)
    
//    convenience init(endPoint: EndPoint) {
//        self.init()
//        self.networkManager = NetworkManager(resource: endPoint)
//    }
    
    func fetchProducts() {
        isLoading.value = true
        self.dataSource.data.value = [ProductViewModel()]
//        networkManager?.service.request(withCompletion: { [weak self] (result) in
//            self?.isLoading.value = false
//            switch result {
//            case .failure(_ ):
//                self?.alertModel.value = AlertModel(actionModels: [.init(title: "Retry", style: .default, handler: { (action) in
//                    self?.fetchFeed()
//                })], title: "Oops", message: "Something happened", prefferedStyle: .alert)
//            case .success(let feedWrapper):
//                self?.feedCellViewModels = feedWrapper.feedModels?.map({FeedCellViewModel(userDiaplayName: $0.owner?.display_name, userImageUrlString: $0.owner?.profile_image, title: $0.title, viewCount: $0.view_count, dateCreated: $0.creation_date, link: $0.link, isAnswered: $0.is_answered)}) ?? []
//
//
//                guard self?.validateResults() ?? false
//                else { self?.updateNoResultsFound.value = true; return }
//                self?.dataSource.data.value = self?.getFilteredResults() ?? []
//            }
//        })
    }
}
