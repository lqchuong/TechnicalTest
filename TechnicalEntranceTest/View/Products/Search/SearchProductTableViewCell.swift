//
//  SearchProductTableViewCell.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/30/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit

class SearchProductTableViewCell: UITableViewCell {

    @IBOutlet weak var lb_Order: UILabel!
    @IBOutlet weak var lb_Name: UILabel!
    @IBOutlet weak var img_Product: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadData(product: Info){
        lb_Order.text = "\(product.TimeDelivery) min - for \(product.Person) person"
        lb_Name.text = product.Name
        img_Product.image = UIImage.init(named: product.Url)
    }
}
