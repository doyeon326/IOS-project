//
//  RegisterViewController.swift
//  SigninAndSignout
//
//  Created by Tony Jung on 2020/08/18.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var tapGesture = UITapGestureRecognizer()
    @IBOutlet var viewTap: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    
    
    @IBAction func valueSetUp(_ sender: Any) {
        UserInformation.shared.name = self.nameField.text
        UserInformation.shared.pw = self.pwField.text
        UserInformation.shared.phoneNumber = self.phoneNumberField.text
        //image
        
        
    }
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
      //  picker.allowsEditing = true
        return picker
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchUpSelectImageButton(_:)))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        viewTap.addGestureRecognizer(tapGesture)
        viewTap.isUserInteractionEnabled = true
    }
    
    @objc func touchUpSelectImageButton(_ sender: UIRotationGestureRecognizer){
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.imageView.image = originalImage
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func tapView(_sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
 
    
    @IBAction func dismissModal(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //TODO: 비밀번호 확인
    
}
