//
//  ProductViewController.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

class ProductViewController: UIViewController, Storyboarded, Loadable, AlertPresentableView, GenericPickerPresentorable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var barcodeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Coordinator
    weak var coordinator: ProductListCoordinator?
    
    // MARK: - ImagePicker
    var imagePicker: ImagePicker!
    
    // MARK: - Scanner
    var scannerController: ScannerViewController?
    
    // MARK: - Action
    var action: ProductListCoordinator.ProductAction!
    
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
    
    func addDismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target:     self, action: #selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @IBAction func didTapChooseBarcode(_ sender: UIButton) {
        guard let scannerController = scannerController else { return }
        present(scannerController, animated: true, completion: nil)
    }
    
    @IBAction func didTapChooseCategory(_ sender: UIButton) {
        productViewModel?.didTapOnCategoryPicker()
    }
    
    @IBAction func didTapChooseImage(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
        guard let product = productViewModel?.didTapSubmit() else { return }
        coordinator?.didSubmitProductFor(action: action, domainProductModel: product)
    }
}

extension ProductViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let name = textField.text, !name.isEmpty else { return }
        productViewModel?.didChangeName(name)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Private functions
private extension ProductViewController {
    
    func setupViews() {
        navigationController?.navigationBar.barTintColor = .white
        productNameTextField.delegate = self
        
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        scannerController = ScannerViewController()
        scannerController?.delegate = self
        
        initializeLargeActivityIndicator()
        addDismissKeyboard()
    }
    
    func bindViewModel() {
        productNameTextField.text = productViewModel?.productDomainModel?.name
        barcodeLabel.text = productViewModel?.productDomainModel?.barcode
        categoryLabel.text = productViewModel?.productDomainModel?.category.descriptionTitle
        imageView.image = UIImage(data: productViewModel?.productDomainModel?.image ?? Data())
        
        productViewModel?.productCategoryCode.bind({ [weak self] (category) in
            self?.categoryLabel.text = category
        })
        
        productViewModel?.isLoading.bindAndNotify({ [weak self] (isLoading) in
            isLoading ? self?.showIndicator() : self?.hideIndicator()
        })
    }
}

extension ProductViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        imageView.image = image
        guard let imageData = image?.jpegData(compressionQuality: 1) else { return }
        productViewModel?.didSelectImage(image: imageData)
    }
}

extension ProductViewController: BarcodeScannerDelegate {
    func didScanned(barcode: String?) {
        barcodeLabel.text = barcode
        
        guard let barcode = barcode else { return }
        productViewModel?.didScanBarcode(code: barcode)
    }
}

