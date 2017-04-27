//
//  TryItOnViewController.swift
//  WearIt
//
//  Created by Dhruv Shah on 4/16/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit
import UIView_draggable
import KLCPopup
import CoreGraphics

class TryItOnViewController: UIViewController, 
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    let mirrorSelfiePicker = UIImagePickerController()
    var pickedImage: UIImage?
    var shirtImage: UIImage?

    var marker1: UIView?
    var marker2: UIView?
    var marker3: UIView?
    var marker4: UIView?
    
    var humanLoc: [CGPoint] = []
    var shirtLoc: [CGPoint] = []

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pop1V: UIView!
    @IBOutlet weak var pop2V: UIView!
    
    var progress:Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        marker1 = UIView(frame: CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 30, height: 30))
        marker1?.backgroundColor = UIColor.red
        marker2 = UIView(frame: CGRect(x: self.view.center.x + 20, y: self.view.center.y - 50, width: 30, height: 30))
        marker2?.backgroundColor = UIColor.blue
        marker3 = UIView(frame: CGRect(x: self.view.center.x + 20, y: self.view.center.y + 20, width: 30, height: 30))
        marker3?.backgroundColor = UIColor.green
        marker4 = UIView(frame: CGRect(x: self.view.center.x - 50, y: self.view.center.y + 20, width: 30, height: 30))
        marker4?.backgroundColor = UIColor.orange

    }
    
    @IBAction func dismissPop(_ sender: Any) {
        KLCPopup.dismissAllPopups()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        marker1?.cagingArea = imgView.frame
        marker2?.cagingArea = imgView.frame
        marker3?.cagingArea = imgView.frame
        marker4?.cagingArea = imgView.frame
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.  
        let pop1: KLCPopup = KLCPopup(contentView: pop1V)
        let pop2: KLCPopup = KLCPopup(contentView: pop2V)
        
        if let img:UIImage = self.pickedImage {
            imgView.contentMode = UIViewContentMode.scaleAspectFill
            imgView.image = img
            pop2V.isHidden = false
            pop2.show()
            imgView.isHidden = false
            
            marker1?.enableDragging()
            marker2?.enableDragging()
            marker3?.enableDragging()
            marker4?.enableDragging()
            
            self.view.addSubview(marker1!)
            self.view.addSubview(marker2!)
            

            print(self.view.frame.height - self.imgView.frame.height)
            
        }
        else {
            mirrorSelfiePicker.delegate = self            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                mirrorSelfiePicker.sourceType = UIImagePickerControllerSourceType.camera
                mirrorSelfiePicker.allowsEditing = true
                mirrorSelfiePicker.cameraCaptureMode = .photo
                mirrorSelfiePicker.showsCameraControls = true
                mirrorSelfiePicker.allowsEditing = false
                mirrorSelfiePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
                pop1V.isHidden = false
                present(mirrorSelfiePicker, animated: false,completion: nil)
                pop1.show()
                
                
            } else {
                noCamera()
            }
        }
    }
    
    @IBAction func doOverlay() {
        self.progress += 1
        switch self.progress {
        case 1:
            /*
            var imageViewPoint = CGPoint(x: marker1!.center.x - self.imgView.frame.minX, y: marker1!.center.y - self.imgView.frame.minY)
            var percentX = imageViewPoint.x / self.imgView.frame.size.width;
            var percentY = imageViewPoint.y / self.imgView.frame.size.height;
            humanLoc.append(CGPoint(x: self.pickedImage!.size.width * percentX, y: self.pickedImage!.size.height * percentY))
            
            marker1!.frame = CGRect(x: imageViewPoint.x, y: imageViewPoint.y, width: marker1!.frame.size.width, height: marker1!.frame.size.height)


             imageViewPoint = CGPoint(x: marker2!.center.x - self.imgView.frame.minX, y: marker2!.center.y - self.imgView.frame.minY)
            percentX = imageViewPoint.x / self.imgView.frame.size.width;
             percentY = imageViewPoint.y / self.imgView.frame.size.height;
            humanLoc.append(CGPoint(x: self.pickedImage!.size.width * percentX, y: self.pickedImage!.size.height * percentY))
            
             imageViewPoint = CGPoint(x: marker3!.center.x - self.imgView.frame.minX, y: marker3!.center.y - self.imgView.frame.minY)
             percentX = imageViewPoint.x / self.imgView.frame.size.width;
             percentY = imageViewPoint.y / self.imgView.frame.size.height;
            humanLoc.append(CGPoint(x: self.pickedImage!.size.width * percentX, y: self.pickedImage!.size.height * percentY))*/
            
            
            humanLoc.append(marker1!.center)
            humanLoc.append(marker2!.center)
            shirtImage = UIImage(named: "tshirt")
            performImageOverlay()
            break
        case 2:
            /*
            var imageViewPoint = CGPoint(x: marker1!.center.x - self.imgView.frame.minX, y: marker1!.center.y - self.imgView.frame.minY)
            var percentX = imageViewPoint.x / self.imgView.frame.size.width;
            var percentY = imageViewPoint.y / self.imgView.frame.size.height;
            shirtLoc.append(CGPoint(x: self.pickedImage!.size.width * percentX, y: self.pickedImage!.size.height * percentY))
            
            imageViewPoint = CGPoint(x: marker2!.center.x - self.imgView.frame.minX, y: marker2!.center.y - self.imgView.frame.minY)
            percentX = imageViewPoint.x / self.imgView.frame.size.width;
            percentY = imageViewPoint.y / self.imgView.frame.size.height;
            shirtLoc.append(CGPoint(x: self.pickedImage!.size.width * percentX, y: self.pickedImage!.size.height * percentY))
            
            imageViewPoint = CGPoint(x: marker3!.center.x - self.imgView.frame.minX, y: marker3!.center.y - self.imgView.frame.minY)
            percentX = imageViewPoint.x / self.imgView.frame.size.width;
            percentY = imageViewPoint.y / self.imgView.frame.size.height;
            shirtLoc.append(CGPoint(x: self.pickedImage!.size.width * percentX, y: self.pickedImage!.size.height * percentY))*/
            self.present(self.storyboard!.instantiateViewController(withIdentifier: "tabBC"), animated: true, completion: nil)
            break
        case 3:
            break
        default: break
        }
    }
    
    func performImageOverlay() {
        let realFrame = CGRect(x: humanLoc[0].x, y: humanLoc[0].y, width: humanLoc[1].x - humanLoc[0].x, height: humanLoc[1].y - humanLoc[0].y)
        let newIMV = UIImageView(frame: realFrame)
        newIMV.image = self.shirtImage!
        newIMV.contentMode = UIViewContentMode.scaleAspectFill
        //newIMV.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 1.0, alpha: 0.6)
        self.view.addSubview(newIMV)
        
    }
    
    func noCamera() {
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: { (action: UIAlertAction) in
                self.present(self.storyboard!.instantiateViewController(withIdentifier: "tabBC"), animated: true, completion: { 
                    
                })
        })
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delegates
    private func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {        
        if let first = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.pickedImage = UIImage(cgImage: first.cgImage!, scale: 1.0, orientation: UIImageOrientation.right)
        }
        else {
            print("FIRST ERROR")
        }
        dismiss(animated:true, completion: nil)

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
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


extension UIImage {
    func cropRect() -> CGRect {
        let cgImage = self.cgImage!
        let context = createARGBBitmapContextFromImage(inImage: cgImage)
        if context == nil {
            return CGRect.zero
        }
        
        let height = CGFloat(cgImage.height)
        let width = CGFloat(cgImage.width)
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context!.draw(cgImage, in: rect)
        
        guard let data = context?.data?.assumingMemoryBound(to: UInt8.self) else {
            return CGRect.zero
        }    
        
        var lowX = width
        var lowY = height
        var highX: CGFloat = 0
        var highY: CGFloat = 0
        
        //Filter through data and look for non-transparent pixels.
        for y in 0..<Int(height)  {
            for x in 0..<Int(width)  {
                let pixelIndex = (width * CGFloat(y) + CGFloat(x)) * 4 /* 4 for A, R, G, B */
                
                if data[Int(pixelIndex)] != 0 { //Alpha value is not zero pixel is not transparent.
                    if (CGFloat(x) < lowX) {
                        lowX = CGFloat(x)
                    }
                    if (CGFloat(x) > highX) {
                        highX = CGFloat(x)
                    }
                    if (CGFloat(y) < lowY) {
                        lowY = CGFloat(y)
                    }
                    if (CGFloat(y) > highY) {
                        highY = CGFloat(y)
                    }
                }
            }
        }
        
        
        return CGRect(x: lowX, y: lowY, width: highX-lowX, height: highY-lowY)
    }
    
    func createARGBBitmapContextFromImage(inImage: CGImage) -> CGContext? {
        
        let width = inImage.width
        let height = inImage.height
        
        let bitmapBytesPerRow = width * 4
        let bitmapByteCount = bitmapBytesPerRow * height
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let bitmapData = malloc(bitmapByteCount)
        if bitmapData == nil {
            return nil
        }
        
        let context = CGContext (data: bitmapData,
                                 width: width,
                                 height: height,
                                 bitsPerComponent: 8,      // bits per component
            bytesPerRow: bitmapBytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        return context
    }
}
