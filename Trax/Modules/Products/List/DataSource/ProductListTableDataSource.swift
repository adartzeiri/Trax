//
//  ProductListTableDataSource.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

class ProductListTableDataSource: GenericDataSource<[DomainProduct]> ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellID) as! ProductTableViewCell
        cell.domainProduct = data.value[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        data.value[section].first?.category.title
    }
}
