//
//  HeaderViewCell.swift
//  TechnicalEntranceTest
//
//  Created by Sskey dev on 7/30/19.
//  Copyright © 2019 Sskey dev. All rights reserved.
//

import UIKit
import ExpyTableView

class HeaderViewCell: UITableViewCell {

    @IBOutlet weak var lb_Title: UILabel!
    @IBOutlet weak var img_ic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadData(title: String) {
        lb_Title.text = (title == "1") ? "VIDEO RECIPES" : "RECIPES"
    }
}
extension HeaderViewCell: ExpyTableViewHeaderCell {
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        
        switch state {
        case .willExpand:
            arrowDown(animated: !cellReuse)
        case .willCollapse:
            arrowRight(animated: !cellReuse)
        case .didExpand:
            break
        case .didCollapse:
            break
        }
    }
    
    private func arrowDown(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) {
            self.img_ic.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        }
    }
    
    private func arrowRight(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) {
            self.img_ic.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
}
