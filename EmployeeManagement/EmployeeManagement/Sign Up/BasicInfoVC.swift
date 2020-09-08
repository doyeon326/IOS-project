//
//  BasicInfoVC.swift
//  EmployeeManagement
//
//  Created by Jinyung Yoon on 08/09/2019.
//  Copyright © 2019 kings. All rights reserved.s
//

import UIKit
import Alamofire

class BasicInfoVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userPasswordCheck: UITextField!
    @IBOutlet weak var userMobile: UITextField!
    
    @IBOutlet var segcontrolUserCategory: UISegmentedControl!
    
    @IBOutlet var lbPolicyClick: UILabel!
    @IBOutlet weak var termsAgreement: UIButton!
    @IBOutlet weak var nextPage: UIButton!
    
    var userType: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmail.delegate = self
        userName.delegate = self
        userPassword.delegate = self
        userPasswordCheck.delegate = self
        userMobile.delegate = self
        
        termsAgreement.isSelected = false
        termsAgreement.addTarget(self, action: #selector(isClicked), for: .touchUpInside)
        
//        nextPage.addTarget(self, action: #selector(didClick), for: .touchUpInside)
        
        lbPolicyClick.isUserInteractionEnabled = true
        lbPolicyClick.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lbPolicyClickEvent)))
    }
    
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {

        if #available(iOS 13.0, *) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        }

        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    
//MARK: - Click Event
    
    @objc
    func isClicked() {
        if termsAgreement.isSelected == false {
            termsAgreement.setImage(UIImage(named: "check_checked"), for: .normal)
        } else {
            termsAgreement.setImage(UIImage(named: "check_uncheck"), for: .normal)
        }
        termsAgreement.isSelected = !termsAgreement.isSelected
    }
    
    
//    @objc
//    func didClick() {
//
//        if !isEmptyTextField() ||
//            !isValidateTextField() {
//            return
//        }
//
//        if !isCheckTerms() {
//            return
//        }
//
//        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "SelectPostion")
//        self.navigationController?.pushViewController(nextVC, animated: true)
//    }
    
    @IBAction func userCategorySelectEvent(_ sender: Any) {
        
        switch segcontrolUserCategory.selectedSegmentIndex {
        case 0:     //알바
            userType = 1
        case 1:     //사장
            userType = 0
        default:
            break
        }
    }
    
    
    @objc
    func lbPolicyClickEvent(sender:UITapGestureRecognizer) {
        
        let popupVC = self.storyboard!.instantiateViewController(withIdentifier: "PopUpViewID")
        popupVC.modalPresentationStyle = .overCurrentContext
        present(popupVC, animated: false, completion: nil)
    }
    
    @IBAction func submitButtonClickEvent(_ sender: Any) {
        
//        if !isEmptyTextField() ||
//            !isValidateTextField() {
//            return
//        }
//
//        if !isCheckTerms() {
//            return
//        }
        
        //기본정보 서버로 전송
        let url = "http://192.168.0.126:3000/api/signup"
        let parameters: Parameters = ["group_id":String(segcontrolUserCategory.selectedSegmentIndex),
                                      "user_email":"ios9@test.com",
                                      "user_pw":"123456789",
                                      "user_nm":"옴팡이2",
                                      "user_phone":"01012345671"]
        
        print("SignUp (BasicInfo) Request URL = \(url)")
        print("SignUp (BasicInfo) Request parameters = \(parameters)")
        
        AF.request(url, method: .post, parameters: parameters).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                print(response)
                
                let resultJSON = data as! NSDictionary
                let resultCode = resultJSON["resultCode"] as! Int
                //let resultMsg = resultJSON["resultMsg"]
                let resultData = resultJSON["resultData"] as! NSDictionary
                
                if resultCode == 1 {
                    //회원가입 성공
                    
                    if (resultData["group_id"] as! NSString).intValue == 1 {
                        //알바 - 메인으로 이동
                        print("회원가입 성공 - 알바")
                        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                        let nextVC = storyboard.instantiateViewController(withIdentifier: "MenuHomeVC")
                        self.present(nextVC, animated: false, completion: nil)
//                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }
                    else {
                        //사장 - 추가정보 입력
                        print("회원가입 성공 - 사장")
                        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "extraInfo")
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }
                }
                else {
                    //회원가입 실패
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "알 수 없는 오류입니다.", handler: nil)
            }
                
        }
    }
    
    
    @IBAction func cancelSignUp(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
//MARK: - 입력값 유효성 체크 함수
    
    func isValidateEmail(_ email: String) -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let isValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        
        if !isValid {
            CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "이메일 형식이 올바르지 않습니다.", handler: nil)
        }
        return isValid
    }
    
    func isValidatePassword(_ password: String) -> Bool {
        
        let passwordRegEx = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8}$"
        let isValid = NSPredicate(format: "SELF MATCHES %@", passwordRegEx).evaluate(with: password)
        
        if !isValid {
            CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "비밀번호 형식이 올바르지 않습니다.", handler: nil)
        }
        return isValid
    }
    
    func isValidatePasswordEqual() -> Bool {
        
        if userPassword.text == userPasswordCheck.text {
            return true
        }
        else {
            CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "비밀번호를 동일하게 입력해 주세요.", handler: nil)
            return false
        }
    }
    
    func isValidatePhoneNumber(_ number: String) -> Bool {
        
        let numberRegEx = "^([0-9]*).{11}$"
        let isValid = NSPredicate(format: "SELF MATCHES %@", numberRegEx).evaluate(with: number)
        
        if !isValid {
            CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "휴대폰번호 형식이 올바르지 않습니다.", handler: nil)
        }
        return isValid
    }
    
    func isValidateTextField() -> Bool {
        
        if isValidateEmail(userEmail.text!) &&
            isValidatePassword(userPassword.text!) &&
            (userPassword.text == userPasswordCheck.text) &&
            isValidatePhoneNumber(userMobile.text!) {
            return true
            
        } else {
            CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "입력값을 확인해주세요.", handler: nil)
            return false
        }
    }
    
    func isEmptyTextField() -> Bool {
        
        if !(userEmail.text ?? "").isEmpty &&
            !(userName.text ?? "").isEmpty &&
            !(userPassword.text ?? "").isEmpty &&
            !(userPasswordCheck.text ?? "").isEmpty &&
            !(userMobile.text ?? "").isEmpty {
            return true
            
        } else {
            CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "입력되지 않은 값이 있습니다.", handler: nil)
            return false
        }
    }
    
    func isCheckTerms() -> Bool {
        
        if (termsAgreement.isSelected == true) {
            return true
        }
        else {
            CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "이용약관, 개인정보처리방침 동의에 체크해주세요.", handler: nil)
            return false
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
        
        userEmail.resignFirstResponder()
        userName.resignFirstResponder()
        userPassword.resignFirstResponder()
        userPasswordCheck.resignFirstResponder()
        userMobile.resignFirstResponder()
    }
    
    
//MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField.text ?? "").isEmpty {
            
            CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "값이 입력되지 않았습니다.", handler: nil)
        }
        else {
            
            switch textField {
                
            case userEmail:
                if isValidateEmail(userEmail.text!) {
                    userName.becomeFirstResponder()
                }
                
            case userName:
                userPassword.becomeFirstResponder()
                
            case userPassword:
                if isValidatePassword(userPassword.text!) {
                    userPasswordCheck.becomeFirstResponder()
                }
                
            case userPasswordCheck:
                if isValidatePasswordEqual() {
                    userMobile.becomeFirstResponder()
                }
                
            case userMobile:
                if isValidatePhoneNumber(userMobile.text!) {
                    textField.resignFirstResponder()
                }
                
            default:
                break
            }
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
