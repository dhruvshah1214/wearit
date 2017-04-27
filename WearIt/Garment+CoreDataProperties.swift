//
//  Garment+CoreDataProperties.swift
//  WearIt
//
//  Created by Dhruv Shah on 4/26/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import Foundation
import CoreData


extension Garment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Garment> {
        return NSFetchRequest<Garment>(entityName: "Garment")
    }

    @NSManaged public var url: String?
    @NSManaged public var image: NSData?

}
