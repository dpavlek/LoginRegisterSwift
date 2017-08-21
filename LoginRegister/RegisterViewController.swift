//
//  RegisterViewController.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    let registerViewModel = RegisterViewModel()

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var pwdInput: UITextField!
    @IBOutlet weak var pwdReInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        pwdReInput.addTarget(self, action: #selector(pwdTextFieldChanged(_:)), for: .editingChanged)
        pwdInput.addTarget(self, action: #selector(rePwdTextFieldChanged(_:)), for: .editingChanged)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUpAction(_ sender: UIButton) {
        let userInputtedData = registerInfo(username: usernameInput.text, email: emailInput.text, password: pwdInput.text, password2: pwdReInput.text, image: userImage.image)
    }

    func pwdTextFieldChanged(_ textField: UITextField) {
        if pwdInput.text?.characters.count == 0 {
            pwdInput.text = ""
            pwdInput.placeholder = NSLocalizedString("registration_password_error", comment: "")
            /* let alertMessage = NSLocalizedString("registration_password_error", comment: "")
             let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
             alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
             self.present(alert,animated: true,completion: nil) */
        }
    }

    func rePwdTextFieldChanged(_ textField: UITextField) {
        if pwdReInput.text == pwdInput.text {
            pwdReInput.text = ""
            pwdReInput.placeholder = NSLocalizedString("registration_passwords_dont_match", comment: "")
        }
    }

}
