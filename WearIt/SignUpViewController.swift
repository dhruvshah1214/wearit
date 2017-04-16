//
//  SignUpViewController.swift
//  WearIt
//
//  Created by TinoHacks on 4/15/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit
import Firebase
import QuartzCore

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    
    var userStorage: FIRStorageReference! = FIRStorage.storage().reference()
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let picker = UIImagePickerController()
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        errorMessageLabel.isHidden = true
        ref = FIRDatabase.database().reference()
        signUpButton.layer.cornerRadius = 7
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        nameTextField.delegate = self
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }
    
    @IBAction func signUpButonPressed(_ sender: UIButton) {
        guard nameTextField.text != nil, emailTextField.text != nil, usernameTextField.text != nil, passwordTextField.text != nil, profileImageView.image != nil else {return}
        
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let _user = user{
                self.ref.child("Users/\(_user.uid)/ID").setValue(self.usernameTextField.text!)
                
                if let imgData: Data = UIImagePNGRepresentation(self.profileImageView.image!) {
                    let finalRef = self.userStorage.child("Users").child(self.usernameTextField.text!).child("profilePicture.png")
                    _ = finalRef.put(imgData, metadata: nil, completion: { (metadata, error) in
                        if (error != nil) {
                            print(error!)
                        }
                        else {
                            print("SUCCESS")
                        }
                    })

                }
                
            }
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
    
    @IBAction func changeProfileImage(_ sender: UIButton) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            profileImageView.image = image
        }
        dismiss(animated: true, completion: nil)
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
