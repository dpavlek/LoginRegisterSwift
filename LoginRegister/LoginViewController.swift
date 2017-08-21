//
//  LoginViewController.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if User.currentUser?.email == nil {
            navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
