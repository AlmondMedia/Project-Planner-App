//
//  AssignedTaskTableViewCell.swift
//  Planner
//
//  Created by majeed on 31/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class AssignedTaskTableViewCell: UITableViewCell {

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
    @IBOutlet weak var taskActivitiesLabel: UILabel!
    @IBOutlet weak var taskDueActivitiesLabel: UILabel!
    
    var task : Task! {
        didSet{
            taskTitleLabel.text = task.Title.uppercaseString;
            taskActivitiesLabel.text = "\(task.Activities.count) Activities"
            
            let dueActivities = App.getTaskActivityBoard(task).DueActivities.count;
            if(dueActivities > 0){
                taskDueActivitiesLabel.text = "\(dueActivities) Due";
                taskDueActivitiesLabel.alpha = 0.5
            }
            else{
                taskDueActivitiesLabel.text = "";
            }
            if(dueActivities == 0){
                statusView.backgroundColor = App.successColor
            }
            else{
                statusView.backgroundColor = App.dangerColor
            }
        }
    }

}
