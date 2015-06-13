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
    public func all(managedObjectContext: NSManagedObjectContext? = nil) throws -> [QueryResultType] {
        return try builder.execute(managedObjectContext, resultType: resultType)
    }
}

