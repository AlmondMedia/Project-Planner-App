//
//  NewTaskViewController.swift
//  Project-X
//
//  Created by majeed on 04/04/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class NewTaskViewController:  UIViewController, UITextFieldDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(editTask == nil){
            self.budgetTextBox.currencyNumberFormatter = X.getCurrencyFormatter()
            self.budgetTextBox.amount = 0;
            selectedDate = NSDate().tommorrow
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
            dueDateTextBox.text = dateFormatter.stringFromDate(selectedDate)
        }else{
            self.titleTextBox.text = editTask!.Title
            self.budgetTextBox.currencyNumberFormatter = X.getCurrencyFormatter()
            self.budgetTextBox.amount = editTask!.Budget;
            selectedDate = editTask!.DueDate;
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
            dueDateTextBox.text = dateFormatter.stringFromDate(selectedDate)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dismissKeyboard();
        self.titleTextBox.becomeFirstResponder()
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    var editTask = App.Memory.selectedTask
    
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
        
        datePickerView.addTarget(self, action: #selector(NewTaskViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    func datePickerValueChanged(sender:UIDatePicker) {
        
        selectedDate = sender.date
        dueDateTextBox.text = dateFormatter.stringFromDate(selectedDate)
    }
    
    
    @IBAction func budgetTextboxValueChanged(sender: UITextField) {
       
    }
    
    @IBAction func save(sender: AnyObject) {
        if(editTask == nil){
            let task = App.CreateTask(titleTextBox.text!, date : selectedDate, budget : Double(budgetTextBox.amount), template : nil);
            App.Memory.selectedProject!.Tasks.append(task);
            App.pushTask(App.Memory.selectedProject!, task: task)
        } else {
            editTask!.Title = titleTextBox.text!;
            editTask!.Budget = NSDecimalNumber(double: budgetTextBox.amount.doubleValue)
            editTask!.DueDate = selectedDate;
            App.pushTask(App.Memory.selectedProject!, task: self.editTask!)
        }
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    
}
