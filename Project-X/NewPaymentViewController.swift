//
//  NewPaymentViewController.swift
//  Planner
//
//  Created by majeed on 01/06/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class NewPaymentViewController: UIViewController , UITextFieldDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(editPayment == nil){
            self.amountTextBox.currencyNumberFormatter = X.getCurrencyFormatter()
            self.amountTextBox.amount = 0;
            selectedDate = NSDate().tommorrow
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
            dateTextBox.text = dateFormatter.stringFromDate(selectedDate)
        }else{
            self.paidToTextBox.text = editPayment!.ReceivedBy
            self.amountTextBox.currencyNumberFormatter = X.getCurrencyFormatter()
            self.amountTextBox.amount = editPayment!.Amount;
            selectedDate = editPayment!.DateTime;
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
            dateTextBox.text = dateFormatter.stringFromDate(selectedDate)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        self.dismissKeyboard();
        self.amountTextBox.becomeFirstResponder()
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    var editPayment = App.Memory.selectedPayment
    
    @IBOutlet weak var paidToTextBox: UITextField!;
    @IBOutlet weak var dateTextBox: UITextField!;
    @IBOutlet weak var amountTextBox: TSCurrencyTextField!;
    
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
        dateTextBox.text = dateFormatter.stringFromDate(selectedDate)
    }
    
    
    @IBAction func budgetTextboxValueChanged(sender: UITextField) {
        
    }
    
    @IBAction func save(sender: AnyObject) {
        if(editPayment == nil){
            let payment = Payment();
            payment.Amount = NSDecimalNumber(double: amountTextBox.amount.doubleValue)
            payment.DateTime = selectedDate;
            payment.ReceivedBy = paidToTextBox.text!;
            App.Memory.selectedPaymentTask?.Payments.append(payment);
        } else {
            editPayment!.Amount = NSDecimalNumber(double: amountTextBox.amount.doubleValue)
            editPayment!.DateTime = selectedDate;
            editPayment!.ReceivedBy = paidToTextBox.text!;
        }
        
        App.pushTask(App.Memory.selectedProject!, task: App.Memory.selectedPaymentTask!)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
}
