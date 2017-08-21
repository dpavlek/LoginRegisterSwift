//
//  RegisterViewModel.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import Foundation

class RegisterViewModel{
    
    func checkRegisterInput(registrationInfo: registerInfo) throws -> Bool{
        guard registrationInfo.username != nil else{
            throw registrationError.blankUsername
        }
        guard registrationInfo.email != nil else{
            throw registrationError.blankEmail
        }
        guard registrationInfo.password != nil else{
            throw registrationError.wrongPassword
        }
        guard registrationInfo.password == registrationInfo.password2 else{
            throw registrationError.passwordNotEqual
        }
        return true
    }
    
}
