//
//  Save.swift
//  WearIt
//
//  Created by TinoHacks on 4/16/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import Foundation
import UIKit

class Save: NSObject, NSCoding {
    var URL : [URL?]
    var thumbnail : UIImage
    var hiddenImage: UIImage
    
    init(_URL: [URL?], _thumbnail: UIImage, _hiddenImage: UIImage) {
        URL = _URL
        thumbnail = _thumbnail
        hiddenImage = _hiddenImage
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(URL, forKey: "url")
        aCoder.encode(thumbnail, forKey: "thumbnail")
        aCoder.encode(hiddenImage, forKey: "hiddemImage")
    }
    
    required init?(coder aDecoder: NSCoder) {
        URL = aDecoder.decodeObject(forKey: "url") as! [URL]
        thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as! UIImage
        hiddenImage = aDecoder.decodeObject(forKey: "hiddemImage") as! UIImage

    }
    
}
