//
//  ProductListCoordinator.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

class ProductListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationContoller: UINavigationController
    
    init(navigationContoller: UINavigationController) {
        self.navigationContoller = navigationContoller
    }
    
    func start() {
        let productListVC = ProductListViewController.instantiate()
        productListVC.productListViewModel = ProductListViewModel(repository: LocalProductRepository())
        productListVC.coordinator = self
        navigationContoller.pushViewController(productListVC, animated: true)
    }
    
    func navgiateToProductDetailsWith(_ domainProductModel: DomainProduct? = nil) {
        let productVC = ProductViewController.instantiate()
        productVC.productViewModel = ProductViewModel(domainProduct:domainProductModel)
        productVC.coordinator = self
        
        productVC.action = (domainProductModel != nil) ? .edit : .create
       
        navigationContoller.pushViewController(productVC, animated: false)
    }
    
    func didSubmitProductFor(action: ProductAction, domainProductModel: DomainProduct) {
        navigationContoller.popViewController(animated: true)
        guard let productListVC = navigationContoller.viewControllers.first as? ProductListViewController else { return }
        
        switch action {
        case .create:
            productListVC.productListViewModel?.create(product: domainProductModel)
        case .edit:
            productListVC.productListViewModel?.update(product: domainProductModel)
        }
    }
}

extension ProductListCoordinator {
    enum ProductAction {
        case create
        case edit
    }
}

