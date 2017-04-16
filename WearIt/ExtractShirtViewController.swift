//
//  ExtractShirtViewController.swift
//  WearIt
//
//  Created by Dhruv Shah on 4/15/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit
import CoreImage

class ExtractShirtViewController: UIViewController, 
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    let pickerBack = UIImagePickerController()
    let pickerFore = UIImagePickerController()
    
    var backImg: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func phto(_ sender: Any) {
        pickerBack.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerBack.allowsEditing = false
            pickerBack.sourceType = UIImagePickerControllerSourceType.camera
            pickerBack.cameraCaptureMode = .photo
            pickerBack.modalPresentationStyle = .fullScreen
            present(pickerBack,animated: true,completion: nil)
        } else {
            noCamera()
        }
        
    }
    
    @IBAction func nextPhto(_ sender: Any) {
        pickerFore.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerFore.allowsEditing = false
            pickerFore.sourceType = UIImagePickerControllerSourceType.camera
            pickerFore.cameraCaptureMode = .photo
            pickerFore.modalPresentationStyle = .fullScreen
            present(pickerFore,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    
    func noCamera() {
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = UIImage(data: UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage)!)!
        // let maskView = TCMaskView(image: chosenImage)
        // maskView.delegate = self
        dismiss(animated:true, completion: nil)
        // maskView.presentFrom(rootViewController: self, animated: true)
        if picker == pickerBack {
            backImg = chosenImage;
            
        }
        else {
            let newIm = self.maskDark(inp: chosenImage)
            let imv = UIImageView(frame: CGRect(x: 50, y: 50, width: 150, height: 250))
            self.view.addSubview(imv)
            imv.image = newIm;
            imv.backgroundColor = UIColor.blue
            imv.contentMode = UIViewContentMode.scaleAspectFit
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func maskLight(inp: UIImage) -> UIImage {
        let myColorMaskedImage: CGImage = inp.cgImage!;
        let myMaskingColors: [CGFloat] = [150, 255, 150, 255, 150, 255];
        let newImg:CGImage = myColorMaskedImage.copy(maskingColorComponents: myMaskingColors)!
        return UIImage(cgImage: newImg)
    }
    
    func maskDark(inp: UIImage) -> UIImage {
        let myColorMaskedImage: CGImage = inp.cgImage!;
        let myMaskingColors: [CGFloat] = [0, 100, 0, 100, 0, 100];
        let newImg:CGImage = myColorMaskedImage.copy(maskingColorComponents: myMaskingColors)!
        return UIImage(cgImage: newImg)
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
