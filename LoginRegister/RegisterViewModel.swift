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
    
    func prepareAlert(forError errorDesc: String) -> UIAlertController {
        let alertMessage = NSLocalizedString(errorDesc, comment: "")
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
    
    func sendRegistrationToServer(userData: registerInfo, onCompletion: @escaping (() -> Void)) {
        
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
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
    }) }
    
    //    let registerResource = Resource<EmptyJSON>(
    //        params: [
    //            "name": username,
    //            "email": email,
    //            "password": password
    //        ],
    //        paramsPartName: "data",
    //        files: files,
    //        path: "/auth/sign-up",
    //        encoding: .json,
    //        method: .post)
}
