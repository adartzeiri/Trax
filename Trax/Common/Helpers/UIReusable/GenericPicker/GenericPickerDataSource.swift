//
//  GenericPickerDataSource.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

struct GenericRow<T> {
    let type: T
    let title: String
}

protocol GenericPickerDataSourceDelegate: AnyObject {
    func genericPickerDidSelect(item: Any)
}

class GenericPickerDataSource<T>: NSObject, UIPickerViewDelegate , UIPickerViewDataSource {
    
    weak var delegate: GenericPickerDataSourceDelegate?
    
    var items: [GenericRow<T>]
    
    init(with items: [GenericRow<T>]) {
        self.items = items
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.genericPickerDidSelect(item: items[row])
    }
}
