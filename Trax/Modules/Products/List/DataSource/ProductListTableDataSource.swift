//
//  ProductListTableDataSource.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

protocol ProductListTableDataSourceDelegate: class {
    func deleteItem(item: DomainProduct)
}

class ProductListTableDataSource: GenericDataSource<[DomainProduct]> ,UITableViewDataSource {
    
    weak var delegate: ProductListTableDataSourceDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellID) as! ProductTableViewCell
        cell.domainProduct = data.value[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        data.value[section].first?.category.title
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.deleteItem(item: data.value[indexPath.section][indexPath.row])
            //tableView.deleteRows(at: <#T##[IndexPath]#>, with: <#T##UITableView.RowAnimation#>)
        }
    }
}
