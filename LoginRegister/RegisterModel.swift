//
//  RegisterModel.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import Foundation
import UIKit

struct registerInfo {
    let username: String?
    let email: String?
    let password: String?
    let password2: String?
    let image: UIImage?

    func returnDictionary() -> [String: String] {
        let userDict: [String: String] = [
            "name": username ?? "",
            "email": email ?? "",
            "password": password ?? "",
        ]
        return userDict
    }
}

enum registrationError: Error {
    case blankUsername
    case blankEmail
    case wrongPassword
    case passwordNotEqual
    case wrongEmail
}

enum registrationServerError: Error{
    case none
    case error
    case userExists
    case badRequest
}
