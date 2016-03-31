//
//  AttributeTest.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 3/31/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData


class AttributeTest: NSManagedObject {
    
    @NSManaged var string: String
    @NSManaged var float: NSNumber
    @NSManaged var double: NSNumber
    @NSManaged var decimal: NSDecimalNumber
    @NSManaged var integer16: NSNumber
    @NSManaged var integer32: NSNumber
    @NSManaged var integer64: NSNumber
    @NSManaged var binary: NSData
    @NSManaged var date: NSDate
    @NSManaged var boolean: NSNumber
}
