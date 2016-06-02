//
//  PaymentTableViewCell.swift
//  Planner
//
//  Created by majeed on 25/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var payment : Payment = Payment() { didSet {
        UpdateUI();
        }}
    
    
    @IBOutlet weak var statusColorView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    func UpdateUI()
    {
        
        amountLabel.text = X.numToCurrency(payment.Amount);
        dateLabel.text = X.getDateString(payment.DateTime, format: "dd MMM yyyy");
        detailsLabel.text = payment.ReceivedBy
        
    }


}
