//
//  LoginViewController.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginViewModel = LoginViewModel()
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInput.addTarget(self, action: #selector(pwdTextFieldChanged(_:)), for: .editingDidEnd)
        emailInput.addTarget(self, action: #selector(emailTextFieldChanged(_:)), for: .editingDidEnd)
        if User.currentUser?.email == nil {
            navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
        signInButton.isEnabled = false
    }
    
    func pwdTextFieldChanged(_ textField: UITextField){
        if checkEmailValidity(),checkPasswordValidity(){
            signInButton.isEnabled = true
        }
    }
    
    func emailTextFieldChanged(_ textField: UITextField){
        if checkEmailValidity(),checkPasswordValidity(){
            signInButton.isEnabled = true
        }
    }
    
    func checkPasswordValidity() -> Bool{
        if let password = passwordInput.text{
            if password.characters.count >= 5{
                return true
            }
        }
        return false
    }
    
    func checkEmailValidity() -> Bool{
        if let email = emailInput.text{
            if email.isEmail(){
                return true
            }
        }
        return false
    }
    
    @IBAction func dismissLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ForgotPasswordAction(_ sender: UIButton) {
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "registrationViewController")
        self.present(controller, animated: true, completion: nil)
    }
    
}
