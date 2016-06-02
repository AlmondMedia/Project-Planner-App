//
//  PaymentTasksTableViewCell.swift
//  Planner
//
//  Created by majeed on 25/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class PaymentTasksTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskCostLabel: UILabel!
    @IBOutlet weak var taskBalanceLabel: UILabel!
    
    var task : Task! {
        didSet{
            taskTitleLabel.text = task.Title.uppercaseString;
            taskCostLabel.text = "COST : " + X.numToCurrency(App.getTaskCosts(task).TotalCost)
            
            let totalAmount : Double = task.Payments.reduce(0.0) { $0 + $1.Amount.doubleValue};
            let balance = totalAmount - App.getTaskCosts(task).TotalCost.doubleValue;
            if(balance < 0)
            {
                //balanceTitleLabel.text = "UNPAID"
                statusView.backgroundColor = App.dangerColor
                taskBalanceLabel.text = X.numToCurrency(NSDecimalNumber(double :totalAmount));
            } else if(balance > 0){
                //balanceTitleLabel.text = "EXCESS"
                statusView.backgroundColor = App.successColor
                taskBalanceLabel.text = X.numToCurrency(NSDecimalNumber(double :totalAmount));
            }
            else{
                //balanceTitleLabel.text = "BALANCE"
                statusView.backgroundColor = App.successColor
                taskBalanceLabel.text = X.numToCurrency(NSDecimalNumber(double :totalAmount));
            }
        }
    }

}
