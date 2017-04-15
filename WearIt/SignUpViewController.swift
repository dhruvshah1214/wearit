//
//  SignUpViewController.swift
//  WearIt
//
//  Created by TinoHacks on 4/15/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageLabel.isHidden = true
    }
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func signUpButonPressed(_ sender: UIButton) {
        if let emailText = emailTextField.text{
            if let passwordText = passwordTextField.text{
                FIRAuth.auth()?.createUser(withEmail: emailText, password: passwordText) { (user, error) in
                    if error != nil{
                        self.errorMessageLabel.isHidden = false
                        self.errorMessageLabel.numberOfLines = 0
                        self.errorMessageLabel.text = error.debugDescription
                        print(error.debugDescription)
                    }else{
                        self.updateUsersProfile {
                            self.performSegue(withIdentifier: "segueToMain", sender: self)
                        }
                    }
                }
            }
        }
        
    }
    
    private func updateUsersProfile(completion: @escaping () -> Void){
        let user = FIRAuth.auth()?.currentUser
        if let user = user {
            let changeRequest = user.profileChangeRequest()
            changeRequest.displayName = usernameTextField.text
            //changeRequest.photoURL
            changeRequest.commitChanges(completion: { (error) in
                if error != nil {
                    print("Could not add name and photo to profile")
                }
                else {
                    completion()
                }
            })
        }
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
