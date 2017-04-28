//
//  PostFinalStepViewController.swift
//  WearIt
//
//  Created by Dhruv Shah on 4/24/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit

class PostFinalStepViewController: UIViewController  {
    var postImage: UIImage?
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var clothesView: CardAnimationView!
    var garments: [Garment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clothesView.cardSize = (300,300)
        clothesView.dataSourceDelegate = self
        self.navigationController?.isNavigationBarHidden = false
        
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
    
    @IBAction func sharePost(_ sender: UIBarButtonItem) {
        
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

extension PostFinalStepViewController: CardAnimationViewDataSource {
    func numberOfVisibleCards() -> Int {
        return min(garments.count, 4)
    }
    
    func numberOfCards() -> Int {
        return 0
    }
    
    func cardNumber(_ number: Int, reusedView: BaseCardView?) -> BaseCardView {
        var retView : ImageCardView? = reusedView as? ImageCardView
        print(" 🃏 Requested card number \(number)")
        if retView == nil {
            retView = ImageCardView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        } else {
            print(" ✌️ View Cached ✌️ ")
        }
        retView!.imageView.image = UIImage(data: garments[number].image! as Data)
        return retView!
    }
}
