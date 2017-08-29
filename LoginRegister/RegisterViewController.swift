//
//  RegisterViewController.swift
//  LoginRegister
//
//  Created by COBE Osijek on 21/08/2017.
//  Copyright © 2017 COBE Osijek. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let registerViewModel = RegisterViewModel()
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var pwdInput: UITextField!
    @IBOutlet weak var pwdReInput: UITextField!
    @IBOutlet weak var clickToChangeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGestureRecognizer)
        pwdInput.addTarget(self, action: #selector(pwdTextFieldChanged(_:)), for: .editingDidEnd)
        pwdReInput.addTarget(self, action: #selector(rePwdTextFieldChanged(_:)), for: .editingDidEnd)
    }

    @IBAction func signUpAction(_ sender: UIButton) {
        checkRegistrationInfo { [weak self] userData in
            self?.registerViewModel.sendRegistrationToServer(userData: userData) { [weak self] completion in
                switch completion {
                case .none:
                    self?.dismiss(animated: true, completion: nil)
                case .error:
                    let alert = UIAlertController.prepareAlert(forError: "registration_server_fail")
                    self?.present(alert, animated: true, completion: nil)
                case .userExists:
                    let alert = UIAlertController.prepareAlert(forError: "registration_user_exists")
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        dismiss(animated: true) {
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.userImage.contentMode = .scaleToFill
                self.userImage.image = pickedImage
                self.clickToChangeLabel.isHidden = true
            }
        }
    }

    func checkRegistrationInfo(onComplete: ((registerInfo) -> Void)) {
        let userInputtedData = registerInfo(username: usernameInput.text, email: emailInput.text, password: pwdInput.text, password2: pwdReInput.text, image: userImage.image)
        do {
            try registerViewModel.checkRegisterInput(registrationInfo: userInputtedData)
        } catch registrationError.blankEmail {
            let alert = UIAlertController.prepareAlert(forError: "registration_email_empty")
            present(alert, animated: true, completion: nil)
        } catch registrationError.blankUsername {
            usernameInput.text = ""
            let alert = UIAlertController.prepareAlert(forError: "registration_empty_username_error")
            present(alert, animated: true, completion: nil)
        } catch registrationError.wrongPassword {
            pwdInput.text = ""
            pwdReInput.text = ""
            let alert = UIAlertController.prepareAlert(forError: "registration_password_error")
            present(alert, animated: true, completion: nil)
        } catch registrationError.passwordNotEqual {
            pwdReInput.text = ""
            let alert = UIAlertController.prepareAlert(forError: "registration_passwords_dont_match")
            present(alert, animated: true, completion: nil)
        } catch registrationError.wrongEmail {
            emailInput.text = ""
            let alert = UIAlertController.prepareAlert(forError: "registration_email_wrong_format_error")
            present(alert, animated: true, completion: nil)
        } catch {
            let alert = UIAlertController.prepareAlert(forError: "default_error")
            present(alert, animated: true, completion: nil)
        }
        onComplete(userInputtedData)
    }

    @IBAction func dismissRegistration(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func pwdTextFieldChanged(_ textField: UITextField) {
        if let pwdCharCount = pwdInput.text?.characters.count, pwdCharCount < 5 {
            pwdInput.text = ""
            let alert = UIAlertController.prepareAlert(forError: "registration_password_error")
            present(alert, animated: true, completion: nil)
        }
    }

    func rePwdTextFieldChanged(_ textField: UITextField) {
        if pwdReInput.text != pwdInput.text {
            pwdReInput.text = ""
            pwdReInput.placeholder = NSLocalizedString("registration_passwords_dont_match", comment: "")
        }
    }
}
