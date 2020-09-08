//
//  WorkStateVC.swift
//  EmployeeManagement
//
//  Created by kings on 18/09/2019.
//  Copyright © 2019 kings. All rights reserved.
//

import UIKit

class WorkStateVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var lbCurrentTime: UILabel!
    @IBOutlet var lbAuthNumber: UILabel!
    
    @IBOutlet var btnAttendCheck: UIButton!
    
    @IBOutlet var tfAuthNumber: UITextField!
    
    var isAttend: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfAuthNumber.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.navigationItem.title = "출퇴근 관리"
        Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(showCurrentDateAndTime), userInfo: nil, repeats: true)
        
        setSideMenuButton()
    }
    
    @objc func showCurrentDateAndTime() {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd\nHH:mm:ss"
        lbCurrentTime.text = dateFormatter.string(from: date)
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
    
    @IBAction func attendButtonClickEvent(_ sender: Any) {
        
        if isAttend == false {
            //퇴근 -> 출근
//            if isIdAndPwInput() {
//                //서버로 보내기
//
//                //성공하고 나면 버튼백그라운드 변경
//                print(isAttend)
//                btnAttendCheck.setBackgroundImage(UIImage(named: "one_blue.png"), for: .normal)
//                btnAttendCheck.titleLabel?.text = "퇴근하기"
//                lbAuthNumber.isHidden = true
//                tfAuthNumber.isHidden = true
//            }
            //성공하고 나면 버튼백그라운드 변경
            btnAttendCheck.setBackgroundImage(UIImage(named: "one_blue.png"), for: .normal)
            btnAttendCheck.setTitle("퇴근하기", for: .normal)
            lbAuthNumber.isHidden = true
            tfAuthNumber.isHidden = true
            isAttend = true
            print(isAttend)
        }
        else {
            //출근 -> 퇴근
            
            //성공하고 나면 버튼백그라운드 변경
            btnAttendCheck.setBackgroundImage(UIImage(named: "one_green.png"), for: .normal)
            btnAttendCheck.setTitle("출근하기", for: .normal)
            lbAuthNumber.isHidden = false
            tfAuthNumber.isHidden = false
            
            isAttend = false
            print(isAttend)
        }
    }

    
//MARK: - UITextField Event
        
    //화면 여백 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
        
    /**
     * @brief 키보드 숨기기
     *
     * @param 없음
     *
     * @return void
     */
    func keyboardHide() {
        
        tfAuthNumber.resignFirstResponder()
    }
    
    /**
     * @brief 텍스트 필드 입력값 체크
     *
     * @param 없음
     *
     * @return BOOL 성공:TRUE 실패:FALSE
     */
    func isIdAndPwInput() -> Bool {
        
        if (tfAuthNumber.text ?? "").isEmpty {
            
            CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "인증번호를 입력해주세요.", handler: nil)
            
            return false
        }
        return true
    }
    
//MARK: - UITextField Delegate
    
    @objc func keyboardWillShow(_ sender: Notification) {
        
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        
        self.view.frame.origin.y = 0
    }
}
