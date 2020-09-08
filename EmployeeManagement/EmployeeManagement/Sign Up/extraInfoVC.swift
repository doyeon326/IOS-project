//
//  extraInfoVC.swift
//  EmployeeManagement
//
//  Created by Jinyung Yoon on 08/09/2019.
//  Copyright © 2019 kings. All rights reserved.
//

import UIKit

class extraInfoVC: UIViewController {
    @IBOutlet weak var storeName: UITextField!
    @IBOutlet weak var storeNumber: UITextField!
    @IBOutlet weak var storeAddress: UITextField!
    @IBOutlet weak var storeMobile: UITextField!
    
    @IBOutlet weak var signUpCom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpCom.addTarget(self, action: #selector(gogo), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {

        if #available(iOS 13.0, *) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        }

        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    @objc
    func gogo() {
        let alert = UIAlertController(title: nil, message: "회원가입 되었습니다.", preferredStyle: .alert)
    
        let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default){ (action: UIAlertAction) -> Void in
    
        self.showNextVC()
    
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func showNextVC() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "MenuHomeVC")
        present(nextVC, animated: false, completion: nil)
    }

}
