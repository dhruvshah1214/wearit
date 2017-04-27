//
//  PostFinalStepViewController.swift
//  WearIt
//
//  Created by Dhruv Shah on 4/24/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit

class PostFinalStepViewController: UIViewController {
    var postImage: UIImage?
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var clothesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if postImage != nil {
            
        }
        else {
            self.navigationController!.popViewController(animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
