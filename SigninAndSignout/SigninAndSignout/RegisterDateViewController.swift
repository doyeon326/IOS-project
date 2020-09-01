//
//  RegisterDateViewController.swift
//  SigninAndSignout
//
//  Created by Tony Jung on 2020/08/18.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class RegisterDateViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!

    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.dateFormat = "yyy/MM/dd hh:mm:ss"
        return formatter
    }()
    
    @IBAction func didDatePickerValueChanged(_Sender: UIDatePicker){
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_Sender:)), for: UIControl.Event.valueChanged)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func dismissModal(){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func valueSetUp(_sender: Any){
        UserInformation.shared.date = self.datePicker.date
    }
    
    
    @IBAction func modalDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
}
