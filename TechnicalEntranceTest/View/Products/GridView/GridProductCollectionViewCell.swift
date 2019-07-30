//
//  GridProductCollectionViewCell.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/30/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit

class GridProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img_Product: UIImageView!
    @IBOutlet weak var bt_TypeProduct: UIButton!
    @IBOutlet weak var lb_Name: UILabel!
    @IBOutlet weak var lb_Orders: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadData(product:Info){
        img_Product.image = UIImage.init(named: product.Url)
        for item in product.ListType{
            if (item.Primary){
            bt_TypeProduct.setTitle(item.Name, for: .normal)
            }
        }
        lb_Name.text = product.Name
        lb_Orders.text = "\(product.TimeDelivery) min . \(product.Person) person"
    }
}
