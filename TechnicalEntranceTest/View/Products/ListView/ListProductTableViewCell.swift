//
//  ListProductTableViewCell.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/29/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit

class ListProductTableViewCell: UITableViewCell {

    @IBOutlet weak var lb_Name: UILabel!
    @IBOutlet weak var img_Product: UIImageView!
    @IBOutlet weak var lb_ListType: UILabel!
    @IBOutlet weak var lb_Order: UILabel!
    @IBOutlet weak var lb_Rate: UILabel!
    @IBOutlet weak var img_Payment: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData(product: Info){
        lb_Name.text = product.Name
        img_Product.image = UIImage.init(named: product.Url)
        lb_ListType.text = getListType(product: product)
        lb_Order.text = "Order from $\(product.Cost) . \(product.TimeDelivery) min delivery"
        lb_Rate.text = product.Rate
        if (product.Payment == 1){img_Payment.image = UIImage.init(named: "ic_card.png")}
        else if (product.Payment == 2){img_Payment.image = UIImage.init(named: "ic_flash.png")}
        else {img_Payment.image = UIImage.init(named: "")}
    }
    func getListType(product: Info)->String{
        var list = ""
        for item in product.ListType{
            list = list + "\(item.Name) "
        }
        return list
    }
}
