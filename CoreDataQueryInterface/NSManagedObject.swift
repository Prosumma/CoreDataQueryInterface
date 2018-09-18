//
//  NSManagedObject.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension NSManagedObject: Scalar {
    public typealias CDQIComparableType = NSManagedObjectID
    
    public var cdqiAttributeType: NSAttributeType {
        return .objectIDAttributeType
    }
}
