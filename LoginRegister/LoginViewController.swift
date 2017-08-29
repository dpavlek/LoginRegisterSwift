//
//  LoginViewController.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let loginViewModel = LoginViewModel()
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInput.addTarget(self, action: #selector(pwdTextFieldChanged(_:)), for: .editingDidEnd)
        emailInput.addTarget(self, action: #selector(emailTextFieldChanged(_:)), for: .editingDidEnd)
        signInButton.isEnabled = false
        
        emailInput.delegate = self
        passwordInput.delegate = self
        
        emailInput.tag = 0
        passwordInput.tag = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if User.currentUser?.loggedIn == false {
            navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func pwdTextFieldChanged(_ textField: UITextField) {
        if checkEmailValidity(), checkPasswordValidity() {
            signInButton.isEnabled = true
        } else {
            signInButton.isEnabled = false
        }
    }
    
    func emailTextFieldChanged(_ textField: UITextField) {
        if checkEmailValidity(), checkPasswordValidity() {
            signInButton.isEnabled = true
        } else {
            signInButton.isEnabled = false
        }
    }
    
    func checkPasswordValidity() -> Bool {
        if let password = passwordInput.text {
            if password.characters.count >= 5 {
                return true
            }
        }
        return false
    }
    
    func checkEmailValidity() -> Bool {
        if let email = emailInput.text {
            if email.isEmail() {
                return true
            }
        }
        return false
    }
    
    @IBAction func dismissLogin(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ForgotPasswordAction(_ sender: UIButton) {
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        let userLoginData = LoginInfo(email: emailInput.text!, password: passwordInput.text!)
        loginViewModel.signInToService(userInfo: userLoginData) { [weak self] error in
            switch error {
            case .none:
                self?.navigationController?.popViewController(animated: true)
            case .badRequest:
                let alert = UIAlertController.prepareAlert(forError: "login_bad_request")
                self?.present(alert, animated: true, completion: nil)
            case .serverError:
                let alert = UIAlertController.prepareAlert(forError: "server_error")
                self?.present(alert, animated: true, completion: nil)
            case .unauthorized:
                let alert = UIAlertController.prepareAlert(forError: "unauthorized")
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "registrationViewController")
        navigationController?.show(controller, sender: self)
    }
    
}
