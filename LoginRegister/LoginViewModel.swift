//
//  LoginViewModel.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import Foundation
import Alamofire

class LoginViewModel {

    func signInToService(userInfo: LoginInfo) {
        Alamofire.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(userInfo.convertToJSON(), withName: "params")
        },
                         to: Constants.baseURL + "/auth/sign-in",
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
        })
    }
}
