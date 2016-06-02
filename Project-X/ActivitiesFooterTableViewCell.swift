//
//  AddActivityTableViewCell.swift
//  Project-X
//
//  Created by majeed on 16/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class ActivitiesFooterTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var totalCostLabel: UILabel!
    
    var totalCost : NSDecimalNumber = 0 { didSet{ totalCostLabel.text = X.numToCurrency(totalCost)}}

}
