//
//  Constants.swift
//  LoginRegister
//
//  Created by COBE Osijek on 22/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import Foundation
import Alamofire

class Constants{
    static var headers: HTTPHeaders = ["authorization-static": "somethingbackendtemplate"]
    static var authHeaders: HTTPHeaders = Constants.headers
    static let header: String = "somethingbackendtemplate"
    static let baseURL: String = "https://something.herokuapp.com"
}
