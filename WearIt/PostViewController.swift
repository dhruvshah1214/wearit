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
import ImagePicker
import AdobeCreativeSDKCore
import AdobeCreativeSDKImage

class PostViewController: ImagePickerController, UITextFieldDelegate, UITextViewDelegate, ImagePickerDelegate, AdobeUXImageEditorViewControllerDelegate {
    
    var userStorage: FIRStorageReference! = FIRStorage.storage().reference()
    var ref: FIRDatabaseReference! = FIRDatabase.database().reference()
    var photoEditor: AdobeUXImageEditorViewController?
    
    
    override func viewDidLoad() {
        self.configuration = Configuration()
        self.configuration.doneButtonTitle = "Done"
        self.configuration.allowMultiplePhotoSelection = false
        self.imageLimit = 1
        self.configuration.recordLocation = false
        self.configuration.noImagesTitle = "Sorry! There are no images here!"
        self.configuration.cancelButtonTitle = ""
        self.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false;
        self.navigationController!.navigationBar.isHidden = true

        
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        photoEditor = AdobeUXImageEditorViewController(image: images[0])
        photoEditor!.delegate = self
        self.present(photoEditor! as AdobeUXImageEditorViewController, animated: true, completion:nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
    }
    
    func photoEditor(_ editor: AdobeUXImageEditorViewController, finishedWith image: UIImage?) {
        if let finalImage = image {
            let finalStepVC: PostFinalStepViewController = self.storyboard!.instantiateViewController(withIdentifier: "finalStepVC") as! PostFinalStepViewController
            finalStepVC.postImage = finalImage
            editor.dismiss(animated: true, completion: { 
                self.show(finalStepVC, sender: self)
            })
        }
        
    }
    
    func photoEditorCanceled(_ editor: AdobeUXImageEditorViewController) {
        editor.dismiss(animated: true, completion: nil)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        // empty to remove cancel button
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
