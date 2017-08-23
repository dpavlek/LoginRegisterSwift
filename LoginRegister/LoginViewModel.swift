//
//  LoginViewModel.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import Foundation
import Alamofire
import KeychainSwift
import SwiftyJSON

class LoginViewModel {

    let keychain = KeychainSwift()

    func signInToService(userInfo: LoginInfo, onCompletion: @escaping ((LoginError) -> Void)) {
        let urlForRequest = Constants.baseURL + "/auth/sign-in"
        Alamofire.request(urlForRequest, method: .post, parameters: userInfo.convertToDict(), encoding: JSONEncoding.default, headers: Constants.headers).responseJSON { [weak self] response in

            switch response.result {

            case .success(let data):
                print(data)
                let response = JSON(data)
                print(response["statusCode"].intValue)
                guard response["statusCode"].intValue != 400 else {
                    onCompletion(LoginError.badRequest)
                    return
                }
                let token = response["token"].stringValue
                self?.keychain.set(token, forKey: "token")
                User.currentUser?.loggedIn = true
                onCompletion(LoginError.none)

            case .failure(let error):
                print(error)
                onCompletion(LoginError.badRequest)
            }
        }
    }

    // TO-DO: Find a way not to have this declared twice in the app
    func prepareAlert(forError errorDesc: String) -> UIAlertController {
        let alertMessage = NSLocalizedString(errorDesc, comment: "")
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
}
