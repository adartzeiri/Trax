//
//  ProductListTableDataSource.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

class ProductListTableDataSource: GenericDataSource<ProductViewModel> ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellID) as? ProductTableViewCell {
            let viewModel = data.value[indexPath.row]
            cell.productViewModel = viewModel
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
