//
//  LoginVC.swift
//  EmployeeManagement
//
//  Created by kings on 08/09/2019.
//  Copyright © 2019 kings. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var btnMainTEST: UIImageView! //메인 화면 이동 테스트용
    
    @IBOutlet var tfID: UITextField!
    @IBOutlet var tfPW: UITextField!
    
    @IBOutlet var BtnLogin: UIButton!
    @IBOutlet weak var SignUpStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfID.delegate = self
        tfPW.delegate = self
        
        btnMainTEST.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goMenuHome)))
        SignUpStart.addTarget(self, action: #selector(goSignUp), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {

        if #available(iOS 13.0, *) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        }

        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    @IBAction func loginButtonEvent(_ sender: Any) {
        
        keyboardHide()
        
        if isIdAndPwInput() == true {
            
            //로그인 호출
            let url = "http://192.168.0.126:3000/api/login"
            let parameters: Parameters = ["user_email":"test2@test.com", "user_pw":"123456789"]
            
            print("Login Request URL = \(url)")
            
            AF.request(url, method: .post, parameters: parameters).responseJSON { response in
                
                switch response.result {
                case .success(let data):
                    print(response)
                    
                    let resultJSON = data as! NSDictionary
                    let resultCode = resultJSON["resultCode"] as! Int
                    //let resultMsg = resultJSON["resultMsg"]
                    //let resultData = resultJSON["resultData"]
                    
                    if resultCode == 1 {
                        //로그인 성공
                        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                        let nextVC = storyboard.instantiateViewController(withIdentifier: "MenuHomeVC")
                        self.present(nextVC, animated: false, completion: nil)
                    }
                    else {
                        //로그인 실패 (resultCode = 0)
                        CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "로그인에 실패하였습니다. 다시 시도해 주세요.", handler: nil)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    CustomAlertController.shared.showSingleButtonAlert(viewController: self, message: "알 수 없는 오류입니다.", handler: nil)
                }
            }
        }
    }
    
    @objc
    func goMenuHome() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "MenuHomeVC")
        present(nextVC, animated: false, completion: nil)
    }
    
    @objc
    func goSignUp() {
        
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "naviSignUp")
        present(nextVC, animated: true, completion: nil)
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
        
        tfID.resignFirstResponder()
        tfPW.resignFirstResponder()
    }
    
    /**
     * @brief 텍스트 필드 입력값 체크
     *
     * @param 없음
     *
     * @return BOOL 성공:TRUE 실패:FALSE
     */
    func isIdAndPwInput() -> Bool {
        
        if (tfID.text ?? "").isEmpty || (tfPW.text ?? "").isEmpty {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                let alert = UIAlertController(title: "알림",
                                              message: "ID 또는 PW를 입력해주세요.",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "확인",
                                              style: .cancel,
                                              handler: nil))
                
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == tfID {
            tfPW.becomeFirstResponder()
            
        } else {
            tfPW.resignFirstResponder()
            loginButtonEvent((Any).self)
        }
        
        return true
    }
}
