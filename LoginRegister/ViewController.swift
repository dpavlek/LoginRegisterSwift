//
//  ViewController.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginAgainButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    let mainViewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        if !Connectivity.isConnectedToInternet {
            self.loginAgainButton.isEnabled = false
            return
        }
        else if (User.currentUser?.loggedIn)! {
            self.mainViewModel.getUser { [weak self] error in
                switch error {
                case .none:
                    self?.usernameLabel.text = User.currentUser?.username
                    self?.emailLabel.text = User.currentUser?.email
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
    }

    override func viewDidAppear(_ animated: Bool) {
        if User.currentUser?.loggedIn == false && Connectivity.isConnectedToInternet {
            self.pushToLogin()
        }
    }

    func pushToLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "loginViewController")
        self.navigationController?.show(controller, sender: self)
    }

    @IBAction func loginAction(_ sender: UIButton) {
        self.pushToLogin()
    }
}
