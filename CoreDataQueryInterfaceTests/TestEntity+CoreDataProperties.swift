//
//  TestEntity+CoreDataProperties.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 4/1/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TestEntity {

    @NSManaged var binary: NSData?
    @NSManaged var boolean: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var decimal: NSDecimalNumber?
    @NSManaged var double: NSNumber?
    @NSManaged var float: NSNumber?
    @NSManaged var integer16: NSNumber?
    @NSManaged var integer32: NSNumber?
    @NSManaged var integer64: NSNumber?
    @NSManaged var string: String?

}
