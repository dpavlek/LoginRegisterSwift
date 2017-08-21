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
    
    static let currentUser = User()
    
    var username: String?
    var email: String?
    var password: String?
    var icon: UIImage?

    private init?() {
        self.username = nil
        self.email = nil
        self.password = nil
        self.icon = nil
    }
}
