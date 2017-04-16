//
//  ShareViewController.swift
//  WearIt
//
//  Created by TinoHacks on 4/15/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit
import TWPhotoPicker

class ShareViewController: UIViewController {
    
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var cameraView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        var photoPicker: TWPhotoPickerController = TWPhotoPickerController()
        self.present(photoPicker, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func takePhoto(_ sender: UIButton) {
        
    }

    
}
