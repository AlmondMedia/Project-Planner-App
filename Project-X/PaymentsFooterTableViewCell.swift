//
//  PaymentFooterTableViewCell.swift
//  Planner
//
//  Created by majeed on 25/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class PaymentsFooterTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var balanceAmountLabel: UILabel!
    @IBOutlet weak var totalPaymentsLabel: UILabel!
    //@IBOutlet weak var balanceTitleLabel: UILabel!
    
    var task : Task! { didSet{
        let totalAmount : Double = task.Payments.reduce(0.0) { $0 + $1.Amount.doubleValue};
        totalPaymentsLabel.text = X.numToCurrency(NSDecimalNumber(double :totalAmount))
        
        let balance = totalAmount - App.getTaskCosts(task).TotalCost.doubleValue;
//        if(balance < 0)
//        {
//            balanceTitleLabel.text = "UNPAID"
//            balanceTitleLabel.textColor = App.dangerColor
//            balanceAmountLabel.text = X.numToCurrency(NSDecimalNumber(double :(balance * -1)));
//        } else if(balance > 0){
//            balanceTitleLabel.text = "EXCESS"
//            balanceTitleLabel.textColor = App.successColor
//            balanceAmountLabel.text = X.numToCurrency(NSDecimalNumber(double :balance));
//        }
//        else{
//            balanceTitleLabel.text = "BALANCE"
//            balanceTitleLabel.textColor = App.defaultColor
//            balanceAmountLabel.text = X.numToCurrency(NSDecimalNumber(double :balance));
//        }
        }
    }
}
