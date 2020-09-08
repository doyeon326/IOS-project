//
//  CustomAlertController.swift
//  EmployeeManagement
//
//  Created by kings on 15/09/2019.
//  Copyright © 2019 kings. All rights reserved.
//

import UIKit

class CustomAlertController: NSObject {
    
    static let shared = CustomAlertController()
    
    func showSingleButtonAlert(viewController: UIViewController,
                               message: String,
                               handler: ((UIAlertAction) -> Void)?) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: nil,
                                          message: message,
                                          preferredStyle: .alert)
            
            let btnOK = UIAlertAction(title: "확인", style: .cancel, handler: handler)
            
            alert.addAction(btnOK)
            
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
