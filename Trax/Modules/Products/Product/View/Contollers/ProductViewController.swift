//
//  ProductViewController.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

class ProductViewController: UIViewController, Storyboarded, Loadable, AlertPresentableView, GenericPickerPresentorable {
    
    // MARK: - Coordinator
    weak var coordinator: ProductListCoordinator?
    
    // MARK: ViewModel
    var productViewModel: ProductViewModel? { didSet { alertViewModel = productViewModel }}
    
    // MARK: - Protocols Properties
    static var storyboardID: Storyboard = .ProductDetails
    var alertViewModel: AlertPresentableViewModel?
    var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
        bindToAlerts()
        
        productViewModel?.setupPickerView(presenter: self)
    }
    
    // MARK: - Actions
    
}

// MARK: - Private functions
private extension ProductViewController {
    
    func setupViews() {
        navigationController?.navigationBar.barTintColor = .white
        initializeLargeActivityIndicator()
    }
    
    func bindViewModel() {        
        productViewModel?.isLoading.bindAndNotify({ [weak self] (isLoading) in
            isLoading ? self?.showIndicator() : self?.hideIndicator()
        })
    }
}

