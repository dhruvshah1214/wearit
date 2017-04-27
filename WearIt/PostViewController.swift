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
        
        /*
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        let ip : UIImagePickerController = imagePicker
        ip.title = "Camera"
        controllerArray.append(ip)
        
        let library: TWPhotoPickerController = TWPhotoPickerController()
        library.cropBlock =  { (image: UIImage?) in
            if let pickedImage: UIImage = image {
                
            }
        } 
        
        library.title = "Library"
        controllerArray.append(library)
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3), 
            .useMenuLikeSegmentedControl(true), 
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        let horizontalConstraint = NSLayoutConstraint(item: pageMenu!.view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: pageMenu!.view, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: pageMenu!.view, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: pageMenu!.view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.topMargin, multiplier: 1, constant: 0)
        
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)
        
        self.view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
*/
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
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        
    }
    
    func photoEditor(_ editor: AdobeUXImageEditorViewController, finishedWith image: UIImage?) {
        if let finalImage = image {
            let finalStepVC: PostFinalStepViewController = self.storyboard!.instantiateViewController(withIdentifier: "finalStepVC") as! PostFinalStepViewController
            finalStepVC.postImage = finalImage
            self.navigationController!.pushViewController(finalStepVC, animated: true)
        }
        
    }
    
    func photoEditorCanceled(_ editor: AdobeUXImageEditorViewController) {
        
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
