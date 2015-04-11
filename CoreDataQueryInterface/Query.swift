//
//  Query.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

/**
The interface that conforming query builders must implement.

This is really just a sanity check to enforce uniformity.
*/
public protocol Query {
    
    typealias EntityType
    typealias EntityResultType
    typealias ExpressionResultType
    typealias ExecutionResultType
    
    static func from(EntityType.Type) -> EntityResultType
    
    func context(managedObjectContext: NSManagedObjectContext) -> EntityResultType
    func filter(predicate: NSPredicate) -> EntityResultType
    func filter(format: String, arguments: CVaListPointer) -> EntityResultType
    func filter(format: String, argumentArray: [AnyObject]?) -> EntityResultType
    func filter(format: String, _ args: CVarArgType...) -> EntityResultType
    func limit(limit: UInt) -> EntityResultType
    func offset(offset: UInt) -> EntityResultType
    func order(sortDescriptors: [AnyObject]) -> EntityResultType
    func order(sortDescriptors: AnyObject...) -> EntityResultType
    
    func select(properties: [AnyObject]) -> ExpressionResultType
    
    func all(#managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> [ExecutionResultType]?
    func first(#managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> ExecutionResultType?
    func count(#managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> UInt?
}
