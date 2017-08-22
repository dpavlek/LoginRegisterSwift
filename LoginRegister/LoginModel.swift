//
//  LoginModel.swift
//  LoginRegister
//
//  Created by COBE Osijek on 22/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import Foundation

class LoginInfo{
    let email: String
    let password: String
    
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
    
    func convertToJSON() -> Data{
        let loginDict = [
            "email": email,
            "password": password
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: loginDict, options: .prettyPrinted)
        return jsonData!
    }
}
