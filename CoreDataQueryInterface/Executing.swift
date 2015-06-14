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

extension ExpressionQuery {
    public func pluck<T>(name: String? = nil, managedObjectContext: NSManagedObjectContext? = nil) throws -> [T] {
        var result = [T]()
        let results = try all(managedObjectContext) as NSArray
        if results.count > 0 {
            let dictionary = results[0] as! NSDictionary
            let key = name ?? dictionary.allKeys.first! as! String
            result = results.valueForKey(key) as! [T]
        }
        return result
    }
    public func value<T>(name: String? = nil, managedObjectContext: NSManagedObjectContext? = nil) throws -> T? {
        return try limit(1).pluck(name, managedObjectContext: managedObjectContext).first
    }
}