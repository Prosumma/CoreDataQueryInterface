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

extension ExpressionQueryType {
    /**
    Returns the given expression as an array of `T`.
    
    - warning: Any preceding expressions in the CDQI chain are overwritten by `expression`. If the cast to `T` fails,
    a runtime exception will occur.
    */
    public func array<T>(expression: ExpressionType, managedObjectContext: NSManagedObjectContext? = nil) throws -> [T] {
        var builder = self.builder
        builder.expressions = [expression]
        let results = try ExpressionQuery(builder: builder).all(managedObjectContext) as NSArray
        if results.count > 0 {
            let key = (results[0] as! NSDictionary).allKeys.first! as! String
            return results.valueForKey(key) as! [T]
        } else {
            return []
        }
    }
    
    /**
    Returns the given expression as an array of `T`.
    
    - warning: Any preceding expressions in the CDQI chain are overwritten by `expression`. If the cast to `T` fails,
    a runtime exception will occur.
    */
    public func array<T>(managedObjectContext managedObjectContext: NSManagedObjectContext? = nil, _ expression: QueryEntityType.EntityAttributeType -> ExpressionType) throws -> [T] {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return try array(expression(attribute), managedObjectContext: managedObjectContext)
    }
    
    /**
    Returns the value of `expression` for the first row as type `T`. In other words, this returns the value of the first row
    in the first column.
    
    - warning: Any preceding expressions in the CDQI chain are overwritten by `expression`. If the cast to `T` fails,
    a runtime exception will occur.
    */
    public func value<T>(expression: ExpressionType, managedObjectContext: NSManagedObjectContext? = nil) throws -> T? {
        var builder = self.builder
        builder.expressions = [expression]
        if let result = try ExpressionQuery(builder: builder).first(managedObjectContext) {
            let key = result.allKeys.first! as! String
            return (result[key]! as! T)
        } else {
            return nil
        }
    }
    
    /**
    Returns the value of `expression` for the first row as type `T`. In other words, this returns the value of the first row
    in the first column.
    
    - warning: Any preceding expressions in the CDQI chain are overwritten by `expression`. If the cast to `T` fails,
    a runtime exception will occur.
    */
    public func value<T>(managedObjectContext managedObjectContext: NSManagedObjectContext? = nil, _ expression: QueryEntityType.EntityAttributeType -> ExpressionType) throws -> T? {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return try value(expression(attribute), managedObjectContext: managedObjectContext)
    }
}