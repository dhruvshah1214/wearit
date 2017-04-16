//
//  PostTableViewCell.swift
//  WearIt
//
//  Created by TinoHacks on 4/15/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase
import QuartzCore

class PostTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    var articlesOfClothing = [URL?]()
    
    @IBOutlet weak var heart: UIButton!
    
    var ref: FIRDatabaseReference! = FIRDatabase.database().reference()
    
    var post: Post? {
        didSet{
            update()
        }
    }
    
    private func update(){
        if let _post = post{
            profileImageView.image = _post.profileImage
            userLabel.text = _post.user
            contentImage.image = _post.image
            numberOfLikesLabel.text = String(_post.numOfLikes)
            articlesOfClothing = _post.articlesOfClothing
            descriptionLabel.text = post?.description
            
            profileImageView.layer.masksToBounds = false
            profileImageView.layer.cornerRadius = profileImageView.frame.height/2
            profileImageView.clipsToBounds = true
        }
    }
    
    @IBAction func liked(_ sender: UIButton) {
        var numLikes: Int
        if sender.isSelected{
            heart.setBackgroundImage(#imageLiteral(resourceName: "whiteHeart"), for: .normal)
            let currNumOfLikes = Int(numberOfLikesLabel.text!)!
            numLikes = currNumOfLikes - 1
            numberOfLikesLabel.text = String(numLikes)
            sender.isSelected = false
        }else{
            heart.setBackgroundImage(#imageLiteral(resourceName: "redHeart"), for: .normal)
            let currNumOfLikes = Int(numberOfLikesLabel.text!)!
            numLikes = currNumOfLikes + 1
            numberOfLikesLabel.text = String(numLikes)
            sender.isSelected = true
        }
        
        
        self.ref.child("Users").child(self.post!.userID).child("Posts").child(String(self.post!.postID)).child("Likes").setValue(numLikes)

        
    }

}
