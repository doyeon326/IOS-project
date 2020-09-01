//
//  ViewController.swift
//  MyDatePicker
//
//  Created by Tony Jung on 2020/08/17.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss" //customize
        return formatter
    }()
     
    
    
    @IBAction func didDatePickerActionChanged(_ sender: UIDatePicker){
        print("value changed")
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        self.dateLabel.text = dateString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerActionChanged(_:)), for: UIControl.Event.valueChanged)
        
        
        // Do any additional setup after loading the view.
    }


}

