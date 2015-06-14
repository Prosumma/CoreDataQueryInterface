//
//  Executing.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension QueryType {
    public func request(managedObjectContext: NSManagedObjectContext? = nil) -> NSFetchRequest {
        return builder.request(resultType, managedObjectContext: managedObjectContext)
    }
    public func count(managedObjectContext: NSManagedObjectContext? = nil) throws -> UInt {
        return try builder.count(managedObjectContext)
    }
    public func all(managedObjectContext: NSManagedObjectContext? = nil) throws -> [QueryResultType] {
        return try builder.execute(managedObjectContext, resultType: resultType)
    }
    public func first(managedObjectContext: NSManagedObjectContext? = nil) throws -> QueryResultType? {
        return try limit(1).all(managedObjectContext).first
    }
}

