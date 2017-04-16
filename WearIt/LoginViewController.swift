//
//  LoginViewController.swift
//  WearIt
//
//  Created by TinoHacks on 4/15/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit
import Firebase
import QuartzCore

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageLabel.isHidden = true
        emailTextField.layer.cornerRadius = 5.0;
        passwordTextField.layer.cornerRadius = 5
        signUpButton.layer.cornerRadius = 7
        loginButton.layer.cornerRadius = 7
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loggedIn(_ sender: Any) {
        if let emailText = emailTextField.text{
            if let passwordText = passwordTextField.text{
                FIRAuth.auth()?.signIn(withEmail: emailText, password: passwordText) { (user, error) in
                    if error != nil{
                        self.errorMessageLabel.isHidden = false
                        self.errorMessageLabel.text = error.debugDescription
                    }else{
                        self.performSegue(withIdentifier: "segueToMain", sender: self)
                    }
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
