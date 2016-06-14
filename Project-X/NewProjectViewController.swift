
//  Created by user on 10/10/2015.
//  Copyright © 2015 Codev. All rights reserved.
//

import UIKit

class NewProjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(editProject == nil){
            self.budgetTextBox.currencyNumberFormatter = X.getCurrencyFormatter()
            
            self.budgetTextBox.amount = 0;
            selectedDate = NSDate().tommorrow
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
            dueDateTextBox.text = dateFormatter.stringFromDate(selectedDate)
        }else{
            self.titleTextBox.text = editProject!.Title
            self.budgetTextBox.currencyNumberFormatter = X.getCurrencyFormatter()
            
            self.budgetTextBox.amount = editProject!.Budget;
            selectedDate = editProject!.DueDate
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
            dueDateTextBox.text = dateFormatter.stringFromDate(selectedDate)
        }
    }
    
    var editProject = App.Memory.selectedProject
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dismissKeyboard();
        self.titleTextBox.becomeFirstResponder()
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBOutlet weak var titleTextBox: UITextField!;
    @IBOutlet weak var dueDateTextBox: UITextField!;
    @IBOutlet weak var budgetTextBox: TSCurrencyTextField!;
    
    let dateFormatter = NSDateFormatter()
    var selectedDate : NSDate = NSDate().tommorrow
    
    @IBAction func dueDateBeganEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.date = selectedDate
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(NewProjectViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    func datePickerValueChanged(sender:UIDatePicker) {
        
        selectedDate = sender.date
        dueDateTextBox.text = dateFormatter.stringFromDate(selectedDate)
    }
    
    
    @IBAction func budgetTextboxValueChanged(sender: UITextField) {
        
    }
    
    @IBAction func save(sender: AnyObject) {
        if(editProject == nil){
            let project = App.CreateProject(titleTextBox.text!, date : selectedDate, budget : Double(budgetTextBox.amount), template : App.Memory.selectedTemplate);
            App.Data.Projects.append(project);
            
            App.pushProject(project)
        } else{
            editProject!.Title = titleTextBox.text!;
            editProject!.Budget = NSDecimalNumber(double: budgetTextBox.amount.doubleValue)
            editProject!.DueDate = selectedDate;
            App.pushProject(self.editProject!)
            
        }
        
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    
   

}
