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
    /**
    Constructs a fetch request from the preceding CDQI chain.
    
    The entire point of CDQI is to construct and optionally execute a
    fetch request.
    
    - warning: Some kinds of queries require an instance of `NSManagedObjectModel`
    in order for this method to work. This is especially true of expression queries,
    because the model is used to look up information like attribute types, etc.
    While many queries will work without it, passing a model is highly recommended.
    
    - parameter managedObjectModel: An optional `NSManagedObjectModel`. If passed, supercedes the one in the chain.
    */
    public func request(managedObjectModel: NSManagedObjectModel? = nil) -> NSFetchRequest {
        return builder.request(resultType, managedObjectModel: managedObjectModel)
    }
    
    /**
    Same as `request(_:managedObjectModel:)` but gets the model from the given or implied
    `NSManagedObjectContext`.
    
    - parameter managedObjectContext: An optional `NSManagedObjectContext`. If passed, supercedes the one in the chain.
    */
    public func request(managedObjectContext: NSManagedObjectContext? = nil) -> NSFetchRequest {
        return builder.request(resultType, managedObjectContext: managedObjectContext)
    }
    
    /**
    Execute the fetch request built by the CDQI chain.
    
    - parameter managedObjectContext: An optional `NSManagedObjectContext`. If passed, supercedes the one in the chain.
    */
    public func all(managedObjectContext: NSManagedObjectContext? = nil) throws -> [QueryResultType] {
        return try builder.execute(managedObjectContext, resultType: resultType)
    }
    
    /**
    Executes `countForFetchRequest` on the fetch request built by the CDQI chain.
    
    - parameter managedObjectContext: An optional `NSManagedObjectContext`. If passed, supercedes the one in the chain.
    */
    public func count(managedObjectContext: NSManagedObjectContext? = nil) throws -> UInt {
        return try builder.count(managedObjectContext)
    }
    
    /**
    Executes the fetch request built by the CDQI chain and returns the first record, if any.
    
    - note: Calls `limit(1)` before executing for efficiency.
    - parameter managedObjectContext: An optional `NSManagedObjectContext`. If passed, supercedes the one in the chain.
    */
    public func first(managedObjectContext: NSManagedObjectContext? = nil) throws -> QueryResultType? {
        return try limit(1).all(managedObjectContext).first
    }
}

extension ExpressionQuery {
    /**
    "Plucks" a single column from a query result and returns it as an array.
    
    - note: Specifying a value for the `name` parameter does *not* automatically add the column
    to the list of those returned. You must specify the column in a previously chained `select`, e.g.,
    
    `moc.from(Employee).select({$0.salary}).pluck()`
    
    - parameter name: The name of the column to pluck. If not specified, a column is chosen at random.
    - parameter managedObjectContext: An optional `NSManagedObjectContext`. If passed, supercedes the one in the chain.
    */
    public func pluck<T>(name: String? = nil, managedObjectContext: NSManagedObjectContext? = nil) throws -> [T] {
        var result = [T]()
        let results = try all(managedObjectContext) as NSArray
        if results.count > 0 {
            let dictionary = results[0] as! NSDictionary
            // OK, this isn't really "at random" but saying it's the "first" column could be confusing.
            let key = name ?? dictionary.allKeys.first! as! String
            result = results.valueForKey(key) as! [T]
        }
        return result
    }
    
    /**
    Gets the value of the specified column in the first row and casts it to `T`.
    
    - note: Specifying a value for the `name` parameter does *not* automatically add the column
    to the list of those returned. You must specify the column in a previously chained `select`, e.g.,
    
    `moc.from(Employee).select({$0.salary}).value() as! NSNumber`
    
    - warning: If the cast to `T` fails, a runtime exception will occur. A common error here
    is to forget that a type annotation is often needed, e.g., `let number = moc.from(Employee).select("salary").value()`
    will fail to compile. You must say `let number: NSNumber = moc.from(Employee).select("salary").value()`.
    
    - parameter name: The name of the column from which to grab the value. If not specified, a column is chosen at random.
    - parameter managedObjectContext: An optional `NSManagedObjectContext`. If passed, supercedes the one in the chain.
    */
    public func value<T>(name: String? = nil, managedObjectContext: NSManagedObjectContext? = nil) throws -> T? {
        return try limit(1).pluck(name, managedObjectContext: managedObjectContext).first
    }
}