//
//  RegisterViewModel.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewModel {
    
    func checkRegisterInput(registrationInfo: registerInfo) throws {
        guard registrationInfo.username != nil else {
            throw registrationError.blankUsername
        }
        guard registrationInfo.email != nil else {
            throw registrationError.blankEmail
        }
        guard registrationInfo.password != nil else {
            throw registrationError.wrongPassword
        }
        guard registrationInfo.password == registrationInfo.password2 else {
            throw registrationError.passwordNotEqual
        }
        guard (registrationInfo.email?.isEmail())! else {
            throw registrationError.wrongEmail
        }
    }
    
    func sendRegistrationToServer(userData: registerInfo, onCompletion: @escaping ((registrationServerError) -> Void)) {
        
        let imageData: Data = UIImageJPEGRepresentation(userData.image!, 0.02)!
        let jsonData = try? JSONSerialization.data(withJSONObject: userData.returnDictionary(), options: .prettyPrinted)
        print("Image data: \(imageData)")
        
        Alamofire.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(jsonData!, withName: "data")
            MultipartFormData.append(imageData, withName: "image")
        },
                         to: Constants.baseURL + "/auth/sign-up",
                         method: .post,
                         headers: Constants.headers,
                         encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        let response = JSON(data)
                        guard response["statusCode"].intValue != 409 else {
                            onCompletion(registrationServerError.userExists)
                            return
                        }
                    case .failure( _):
                        onCompletion(registrationServerError.error)
                    }
                    debugPrint(response)
                    onCompletion(registrationServerError.none)
                }
            case .failure(let encodingError):
                print(encodingError)
                onCompletion(registrationServerError.error)
            }
        })
    }
}
