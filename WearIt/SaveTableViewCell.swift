//
//  SaveTableViewCell.swift
//  WearIt
//
//  Created by TinoHacks on 4/16/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import UIKit


class SaveTableViewCell: UITableViewCell {

   
    @IBOutlet weak var Thumbnail: UIImageView!
    @IBOutlet weak var URL: UILabel!
    
    
    var save: Save?{
        didSet{
            update()
        }
    }

    @IBAction func Buy(_ sender: Any) {
        //UIApplication.shared.openURL((save?.URL[0])!)
        if let _save = save{
            if UIApplication.shared.canOpenURL(_save.URL[0]!){
                print("URLBLAH: \(String(describing: URL.text))")
                UIApplication.shared.openURL(_save.URL[0]!)
            }
        }
    }
    
    private func update(){
        if let _save = save{
            Thumbnail.image = _save.thumbnail
            URL.text = _save.URL[0]?.path
            print(_save.URL[0]?.path)
        }
    }

}
