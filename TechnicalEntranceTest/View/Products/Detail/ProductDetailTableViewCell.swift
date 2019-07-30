//
//  ProductDetailTableViewCell.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/30/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lb_CostExtras: UILabel!
    @IBOutlet weak var lb_NameExtras: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadData(extras: ExtrasDetail)
    {
        lb_NameExtras.text = extras.Name
        lb_CostExtras.text = "+$\(extras.Cost)"
    }
}
