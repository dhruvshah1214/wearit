//
//  Post+CoreDataProperties.swift
//  WearIt
//
//  Created by Dhruv Shah on 4/26/17.
//  Copyright © 2017 TinoHacks. All rights reserved.
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var userID: String?
    @NSManaged public var displayName: String?
    @NSManaged public var postID: Int64
    @NSManaged public var caption: String?
    @NSManaged public var postImageURL: String?
    @NSManaged public var profileImageURL: String?
    @NSManaged public var likes: Int64
    @NSManaged public var garments: NSOrderedSet?

}

// MARK: Generated accessors for garments
extension Post {

    @objc(insertObject:inGarmentsAtIndex:)
    @NSManaged public func insertIntoGarments(_ value: Garment, at idx: Int)

    @objc(removeObjectFromGarmentsAtIndex:)
    @NSManaged public func removeFromGarments(at idx: Int)

    @objc(insertGarments:atIndexes:)
    @NSManaged public func insertIntoGarments(_ values: [Garment], at indexes: NSIndexSet)

    @objc(removeGarmentsAtIndexes:)
    @NSManaged public func removeFromGarments(at indexes: NSIndexSet)

    @objc(replaceObjectInGarmentsAtIndex:withObject:)
    @NSManaged public func replaceGarments(at idx: Int, with value: Garment)

    @objc(replaceGarmentsAtIndexes:withGarments:)
    @NSManaged public func replaceGarments(at indexes: NSIndexSet, with values: [Garment])

    @objc(addGarmentsObject:)
    @NSManaged public func addToGarments(_ value: Garment)

    @objc(removeGarmentsObject:)
    @NSManaged public func removeFromGarments(_ value: Garment)

    @objc(addGarments:)
    @NSManaged public func addToGarments(_ values: NSOrderedSet)

    @objc(removeGarments:)
    @NSManaged public func removeFromGarments(_ values: NSOrderedSet)

}
