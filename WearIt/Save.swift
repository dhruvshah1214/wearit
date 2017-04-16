//
//  Save.swift
//  WearIt
//
//  Created by TinoHacks on 4/16/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import Foundation
import UIKit

class Save {
    var URL : [URL]
    var thumbnail : UIImage
    
    init(_URL: [URL], _thumbnail: UIImage) {
        URL = _URL
        thumbnail = _thumbnail
    }
}
