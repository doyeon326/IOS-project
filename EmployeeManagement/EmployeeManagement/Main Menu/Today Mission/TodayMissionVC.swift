//
//  TodayMissionVC.swift
//  EmployeeManagement
//
//  Created by kings on 18/09/2019.
//  Copyright © 2019 kings. All rights reserved.
//

import UIKit

class TodayMissionVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "오늘의 미션"
        
        setSideMenuButton()
    }
    
    func setSideMenuButton() {
        
        if let revealVC = self.revealViewController() {
            
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "menu.png")
            btn.target = revealVC
            btn.action = #selector(revealVC.revealToggle(_:))
            
            self.navigationItem.leftBarButtonItem = btn
            
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
}
