//
//  Post.swift
//  WearIt
//
//  Created by TinoHacks on 4/15/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import Foundation
import UIKit

class Post {
    
    var image: UIImage
    var profileImage: UIImage
    var user: String
    var numOfLikes: Int
    var articlesOfClothing: [URL]
    var description: String
    var postID: Int
    var userID: String
    
    init(_image: UIImage, _user: String, _numOfLikes: Int, _articlesOfClothing: [URL], _description: String, _profileImage: UIImage, _postID: Int, _userID: String) {
        image = _image
        user = _user
        numOfLikes = _numOfLikes
        articlesOfClothing = _articlesOfClothing
        description = _description
        profileImage = _profileImage
        userID = _userID
        postID = _postID
    }
}
