//
//  UserInformation.swift
//  SigninAndSignout
//
//  Created by Tony Jung on 2020/08/18.
//  Copyright © 2020 Tony Jung. All rights reserved.
//

import Foundation

class UserInformation{
    static let shared: UserInformation = UserInformation()
    
    var name: String?
    var pw: String?
    var phoneNumber: String?
    var date: Date?
    
    
}
