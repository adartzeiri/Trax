//
//  GenericPickerManager.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

protocol GenericPickerPresentorable: UIViewController {}

protocol GenericPickerManagerDelegate: class {
    func genericPickerManagerDidSelect(item: Any)
}

class GenericPickerManager<T>: GenericPickerDataSourceDelegate {

    weak var delegate: GenericPickerManagerDelegate?
    
    private var pickerView  = UIPickerView()
    private var toolBar     = UIToolbar()
    
    private var items:       [GenericRow<T>]
    private var presentor:   GenericPickerPresentorable
    private var dataSource:  GenericPickerDataSource<T>!
    
    //MARK: - Constants
    let pickerHeight:  CGFloat = 300
    let toolbarHeight: CGFloat = 50

    var selectedItem: Any?
    
    init(with items: [GenericRow<T>], presentor: GenericPickerPresentorable, delegate: GenericPickerManagerDelegate) {
        self.items        = items
        self.presentor    = presentor
        self.delegate     = delegate
        self.selectedItem = items.first
            
        setupDataSource()
        customizePicker()
    }
    
    private func setupDataSource() {
        dataSource = GenericPickerDataSource<T>(with: self.items)
        pickerView.delegate   = self.dataSource
        pickerView.dataSource = self.dataSource
        dataSource.delegate   = self
    }
    
    private func customizePicker() {
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - pickerHeight, width: UIScreen.main.bounds.size.width, height: pickerHeight)
        pickerView.backgroundColor = .white

        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - pickerHeight, width: UIScreen.main.bounds.size.width, height: toolbarHeight))
        toolBar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(title: localized(key: "continue"), style: UIBarButtonItem.Style.done, target: self, action: #selector(onDoneButtonTapped))

        let leftButton: UIBarButtonItem = UIBarButtonItem(title: localized(key: "cancel"), style: UIBarButtonItem.Style.done, target: self, action: #selector(onCancelButtonTapped))
        
        var items = [UIBarButtonItem]()
        
        items.append(leftButton)
        items.append(flexSpace)
        items.append(rightButton)
        
        toolBar.items = items
        toolBar.sizeToFit()

    }
    
    @objc func onDoneButtonTapped() {
        if let selectedItem = selectedItem {
            delegate?.genericPickerManagerDidSelect(item: selectedItem)
        }
        hidePicker()
    }
    
    @objc func onCancelButtonTapped() {
        selectedItem = nil
        hidePicker()
    }
    
    func showPicker() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.presentor.view.addSubview(self.pickerView)
            self.presentor.view.addSubview(self.toolBar)
        }
    }
    
    func hidePicker() {
        pickerView.removeFromSuperview()
        toolBar.removeFromSuperview()
    }
    
    func genericPickerDidSelect(item: Any) {
        selectedItem = item
    }
}

