//
//  User.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    let username: String?
    let email: String?
    let password: String?
    let icon: UIImage?

    init(username: String, email: String) {
        self.username = username
        self.email = email
        self.password = nil
        self.icon = nil
    }
}
