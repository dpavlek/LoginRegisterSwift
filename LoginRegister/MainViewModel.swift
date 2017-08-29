//
//  MainViewModel.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import KeychainSwift
import SwiftyJSON

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class MainViewModel {

    let keychain = KeychainSwift()

    func getUser(onCompletion: @escaping (LoginError) -> Void) {
        let urlForRequest = Constants.baseURL + "/me"
        Constants.authHeaders["authorization"] = keychain.get("token")
        Alamofire.request(urlForRequest, method: .get, encoding: JSONEncoding.default, headers: Constants.authHeaders).responseJSON { response in
            switch response.result {
            case .success(let data):
                print(data)
                let response = JSON(data)
                print(response["statusCode"].intValue)
                guard response["statusCode"].intValue != 400 else {
                    onCompletion(LoginError.badRequest)
                    return
                }
                guard response["statusCode"].intValue != 401 else{
                    onCompletion(LoginError.unauthorized)
                    return
                }
                let id = response["_id"].stringValue
                print(id)
                User.currentUser?.email = response["email"].stringValue
                User.currentUser?.username = response["name"].stringValue
                onCompletion(LoginError.none)
            case .failure(let error):
                print(error)
                onCompletion(LoginError.serverError)
            }
        }
    }
}
