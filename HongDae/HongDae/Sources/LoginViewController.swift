//
//  LoginViewController.swift
//  HongDae
//
//  Created by Tony Jung on 2020/11/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewController LifeCycle
        //화면이 로드 되고 나서 수행되는 메서드
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //화면이 나타나기 전에 수행
        navigationController?.navigationBar.isHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //화면이 나타나고나서 수행
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //화면이 사라지기 전에 수행
        navigationController?.navigationBar.isHidden = false
        
    }
    @IBAction func tappedLoginButton(_ sender: Any) {
        //로그인버튼 눌렀을때 수행
        print("tappedLoginButton")
        
        // 서버에 이메일, 비밀번호를 전달하여 로그인 요청
        let result = requestLogin(email: emailTextField.text ?? "0", password: passwordTextField.text ?? "0")
     
        print(result)
        if result == true {
            // 로그인 성공했을 때,
            performSegue(withIdentifier: "LoginToList", sender: self)
        }else {
            // 로그인 실패했을 때,
            let alertController = UIAlertController(title: "Failed", message: "Email or password is not valid", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
            }
            alertController.addAction(alertAction)
            present(alertController, animated: true)
        }
        
    }
}

func requestLogin(email: String, password: String) -> Bool{
    email == "123123.123" && password == "123123" //만약 한줄일경우 리턴을 생략할 수 있다.
}
