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
        productListVC.productListViewModel = ProductListViewModel()
        productListVC.coordinator = self
        navigationContoller.setNavigationBarHidden(true, animated: true)
        navigationContoller.pushViewController(productListVC, animated: true)
    }
    
    func navgiateToProductDetailsWith(_ productViewModel: ProductViewModel? = nil) {
        let productVC = ProductViewController.instantiate()
        productVC.productViewModel = productViewModel
//        let questionVC = QuestionsViewContoller.instantiate(.Questions)
//        let questionVM = QuestionsViewModel(linkStringURL: stringURL)
//        questionVC.questionsViewModel = questionVM
//        navigationContoller.pushViewController(questionVC, animated: true)
    }
}
