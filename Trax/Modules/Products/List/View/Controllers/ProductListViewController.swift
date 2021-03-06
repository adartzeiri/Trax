//
//  ProductListViewController.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

class ProductListViewController: UIViewController, Storyboarded, Loadable, AlertPresentableView {
    
    // MARK: - UI Outlets & Properties
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Helpers
    private var allowRefresh = true
    
    // MARK: - Coordinator
    weak var coordinator: ProductListCoordinator?
    
    // MARK: ViewModel
    var productListViewModel: ProductListViewModel? { didSet { alertViewModel = productListViewModel }}
    
    // MARK: - Protocols Properties
    static var storyboardID: Storyboard = .ProductList
    var alertViewModel: AlertPresentableViewModel?
    var activityIndicatorView: UIActivityIndicatorView!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setupViews()
        bindViewModel()
        productListViewModel?.fetch()
        bindToAlerts()
    }
    
    // MARK: - Actions
    @IBAction func didTapCreate(_ sender: UIBarButtonItem) {
        coordinator?.navgiateToProductDetailsWith()
    }
    
    @IBAction func didTapEdit(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        sender.title = self.tableView.isEditing ? "Done" : "Edit"
    }
}

// MARK: - Private functions
private extension ProductListViewController {
    func configureTableView() {
        tableView.register(ProductTableViewCell.cellNib, forCellReuseIdentifier: ProductTableViewCell.cellID)
        tableView.delegate   = self
    }
    
    func setupViews() {
        navigationController?.navigationBar.barTintColor = .white
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        //Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        initializeLargeActivityIndicator()
    }
    
    func bindViewModel() {
        productListViewModel?.dataSource.data.bind({ [weak self] _ in
            self?.tableView.dataSource = self?.productListViewModel?.dataSource
            self?.tableView.reloadData()
        })
        
        productListViewModel?.isLoading.bindAndNotify({ [weak self] (isLoading) in
            self?.finishRefresh()
            isLoading ? self?.showIndicator() : self?.hideIndicator()
        })
    }
    
    @objc func refreshData(_ refreshControl: UIRefreshControl) {
        if allowRefresh{
            Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false) { timer in
                timer.invalidate()
                self.allowRefresh = true
            }
            allowRefresh = false
            productListViewModel?.fetch()
        }else{
            finishRefresh()
        }
    }
    
    @objc func finishRefresh()
    {
        refreshControl.endRefreshing()
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let domainProduct = productListViewModel?.dataSource.data.value[indexPath.section][indexPath.row] else { return }
        coordinator?.navgiateToProductDetailsWith(domainProduct)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
        UIView.animate(withDuration: 0.35, delay: 0.04 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
}
