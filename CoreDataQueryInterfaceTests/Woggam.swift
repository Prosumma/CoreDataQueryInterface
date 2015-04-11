//
//  Woggam.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

class Woggam: NSManagedObject, EntityMetadata {

    @NSManaged var name: String
    @NSManaged var size: Int32

    class var entityName: String {
        return "Woggam"
    }
    
}
