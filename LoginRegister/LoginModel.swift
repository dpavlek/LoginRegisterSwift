//
//  LoginModel.swift
//  LoginRegister
//
//  Created by COBE Osijek on 22/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import Foundation

class LoginInfo {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func convertToDict() -> [String: String] {
        
        let loginDict = [
            "email": email,
            "password": password
        ]
        return loginDict
    }
    
    func convertToJSON() -> Data {
        
        let jsonData = try? JSONSerialization.data(withJSONObject: convertToDict(), options: .prettyPrinted)
        return jsonData!
    }
}

enum LoginError: Error{
    case none
    case badRequest
    case serverError
    case unauthorized
}
