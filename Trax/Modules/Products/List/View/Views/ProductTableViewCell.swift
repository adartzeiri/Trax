//
//  ProductTableViewCell.swift
//  Trax
//
//  Created by Adar Tzeiri on 16/02/2021.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var domainProduct: DomainProduct!
    {
        didSet {
            productName.text = domainProduct.name
            let imageData = domainProduct.image
            guard let image = UIImage(data: imageData) else { return }
            productImage.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        productImage.layer.cornerRadius = productImage.frame.size.height/2
        productImage.clipsToBounds = true
        productImage.layer.borderWidth = 1
        productImage.layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension ProductTableViewCell: CellIdentifiable {}
