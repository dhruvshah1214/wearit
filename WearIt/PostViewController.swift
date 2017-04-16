//
//  PostViewController.swift
//  WearIt
//
//  Created by TinoHacks on 4/16/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var userStorage: FIRStorageReference! = FIRStorage.storage().reference()
    var ref: FIRDatabaseReference! = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        keywordTextField.delegate = self
        captionTextView.delegate = self
    }
    
    @IBOutlet weak var yourPhotoImageView: UIImageView!
    @IBOutlet weak var blueprintImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var keywordTextField: UITextField!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    let picker = UIImagePickerController()
    
    var changingYourPhoto = false
    
    @IBAction func changeYourPhoto(_ sender: UIButton) {
        changingYourPhoto = true
        picker.allowsEditing = false
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func changeBlueprintPhoto(_ sender: UIButton) {
        changingYourPhoto = false
        picker.allowsEditing = false
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            if changingYourPhoto{
                yourPhotoImageView.image = image
            }else{
                blueprintImageView.image = image
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submitPost(_ sender: Any) {
        if let user = FIRAuth.auth()?.currentUser {
            let currentTime = String(Date().timeIntervalSinceReferenceDate)
            var username : String?
            ref.child("Users").child(user.uid).child("ID").observeSingleEvent(of: .value, with: { (snapshot) in
                username = snapshot.value as? String
            })
            var description: String = self.captionTextView.text
            print("GOTHER")
            self.ref.child("Users").child(user.uid).child("Posts").observeSingleEvent(of: .value, with: { snapshot1 in
                let postNum = snapshot1.childrenCount + 1
                self.ref.child("Users").child(user.uid).child("Posts").child(String(postNum)).child("Clothing").setValue("")
            self.ref.child("Users").child(user.uid).child("Posts").child(String(postNum)).child("Description").setValue(self.captionTextView.text)
                self.ref.child("Users").child(user.uid).child("Posts").child(String(postNum)).child("Likes").setValue(0)
                
                if let imgData: Data = UIImagePNGRepresentation(self.yourPhotoImageView.image!)  {
                    let finalRef = self.userStorage.child("Users").child(username!).child("Posts").child(description + ".png")
                    _ = finalRef.put(imgData, metadata: nil, completion: { (metadata, error) in
                        if (error != nil) {
                            print(error!)
                        }
                        else {
                            print("SUCCESS")
                        }
                    })
                    
                }
                if let imgData: Data = UIImagePNGRepresentation(self.blueprintImageView.image!) {
                    let finalRef = self.userStorage.child("Users").child(username!).child("Posts").child(description + "HiddenImage.png")
                    _ = finalRef.put(imgData, metadata: nil, completion: { (metadata, error) in
                        if (error != nil) {
                            print(error!)
                        }
                        else {
                            print("SUCCESS")
                        }
                    })
                    
                }

            })
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
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
