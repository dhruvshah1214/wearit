//
//  PostViewController.swift
//  WearIt
//
//  Created by TinoHacks on 4/16/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    @IBOutlet weak var yourPhotoImageView: UIImageView!
    @IBOutlet weak var blueprintImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var keywordTextField: UITextField!
    
    let picker = UIImagePickerController()
    
    var changingYourPhoto = false
    
    @IBAction func changeYourPhoto(_ sender: UIButton) {
        print("was here")
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
