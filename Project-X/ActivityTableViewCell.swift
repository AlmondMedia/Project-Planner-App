//
//  ActivityTableViewCell.swift
//  Project-X
//
//  Created by majeed on 26/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        completedSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        //completedSwitch.thumbTintColor = App.successColor
        completedSwitch.onTintColor = UIColor.blackColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var activity : Activity = Activity() { didSet {
        UpdateUI();
        }}
    
    
    @IBOutlet weak var statusColorView: UIView!
    @IBOutlet weak var dueDaysLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var completedSwitch: UISwitch!

    @IBOutlet weak var doneIconImage: UIImageView!
    @IBOutlet weak var dueStaticLabel: UILabel!
    @IBOutlet weak var daysStaticLabel: UILabel!
    
    func UpdateUI()
    {
        
        dueDaysLabel.text = activity.DueInDays.description
        titleLabel.text = activity.Title;
        costLabel.text = X.numToCurrency(activity.Cost);
        completedSwitch.hidden = false;
        
        dueStaticLabel.text = "DUE IN";
        daysStaticLabel.text = "DAYS";
        
        if(activity.DueInDays < 0)
        {
            statusColorView.backgroundColor = App.dangerColor
            dueStaticLabel.text = "OVERDUE";
            dueDaysLabel.text = (activity.DueInDays * -1).description
            daysStaticLabel.text = activity.DueInDays < -1 ? "DAYS AGO" : "DAY AGO" ;
        }
        else if( activity.DueInDays == 0)
        {
            statusColorView.backgroundColor = App.warningColor
            dueStaticLabel.text = "DUE";
            dueDaysLabel.text = "!";
            daysStaticLabel.text = "TODAY";
        }
        else
        {
            statusColorView.backgroundColor = App.defaultColor
            daysStaticLabel.text = activity.DueInDays > 1 ? "DAYS" : "DAY";
        }
        
        if(activity.IsCompleted == true)
        {
            statusColorView.backgroundColor = App.successColor
            
            dueDaysLabel.hidden = true;
            dueStaticLabel.hidden = true;
            daysStaticLabel.hidden = true;
            doneIconImage.hidden = false;
            completedSwitch.on = true
        }
        else{
            dueDaysLabel.hidden = false;
            dueStaticLabel.hidden = false;
            daysStaticLabel.hidden = false;
            doneIconImage.hidden = true;
            completedSwitch.on = false
        }

    }
    
    @IBAction func completedSwitchValueChanged(sender: UISwitch) {
        if(sender.on == true)
        {
            activity.CompletionDate = NSDate();
            activity.IsCompleted = true;
            //UpdateUI();
            
        }
        else{
            activity.CompletionDate = nil
            activity.IsCompleted = false;
            //UpdateUI();
        }
        App.pushActivity(App.Memory.selectedTask!, activity: activity)
        App.CurrentTaskChangedEvent.raise();
        
    }
    
}
