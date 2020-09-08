//
//  DayOffPopUpVC.swift
//  EmployeeManagement
//
//  Created by kings on 21/09/2019.
//  Copyright © 2019 kings. All rights reserved.
//

class DayOffPopUpVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet var lbSelectedDate: UILabel!
    @IBOutlet var tvDayOffReason: UITextView!
    
    var strSelectedDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbSelectedDate.text = strSelectedDate
        
        tvDayOffReason.layer.borderWidth = 0.5
        tvDayOffReason.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func submitDayOffApproval() {
        
        tvDayOffReason.resignFirstResponder()
        
        if tvDayOffReason.hasText {
            dayOffApprovalRequest(success: {
                //휴가 등록 성공
                self.dismiss(animated: false, completion: nil)
                
            }) { error in
                //휴가 등록 실패
                print(error!.localizedDescription)
                CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "휴가 등록이 실패하였습니다.", handler: nil)
            }
        }
        else {
            CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "사유를 입력해주세요.", handler: nil)
            tvDayOffReason.becomeFirstResponder()
        }
    }
    
    func dayOffApprovalRequest(success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        
        //휴가 등록 api 호출
        
        //휴가 등록 완료
        success()
    }
    
    @IBAction func okButtonClick(_ sender: Any) {
        
        submitDayOffApproval()
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        
        dismiss(animated: false, completion: nil)
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
        
        tvDayOffReason.resignFirstResponder()
    }
    
//MARK: - UITextField Delegate
    
    @objc func keyboardWillShow(_ sender: Notification) {
        
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        
        self.view.frame.origin.y = 0
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tvDayOffReason.text = String()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            
            submitDayOffApproval()
        }
        return true
    }
}
