//
//  Query.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

/**
The protocol to which query providers must conform.
*/
public protocol Query: SequenceType {
    
    typealias EntityType: EntityMetadata, AnyObject
    typealias EntityQueryType
    typealias ExpressionQueryType
    typealias ResultType
    
    var builder: ResultBuilder<EntityType> { get set }
    
    static func from(EntityType.Type) -> EntityQueryType
    
    func context(managedObjectContext: NSManagedObjectContext) -> EntityQueryType
    func filter(predicate: NSPredicate) -> EntityQueryType
    func filter(format: String, arguments: CVaListPointer) -> EntityQueryType
    func filter(format: String, argumentArray: [AnyObject]?) -> EntityQueryType
    func filter(format: String, _ args: CVarArgType...) -> EntityQueryType
    func limit(limit: UInt) -> EntityQueryType
    func offset(offset: UInt) -> EntityQueryType
    func order(sortDescriptors: [AnyObject]) -> EntityQueryType
    func order(sortDescriptors: AnyObject...) -> EntityQueryType
    
    func select(properties: [AnyObject]) -> ExpressionQueryType
    
    func all(#managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> [ResultType]?
    func first(#managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> ResultType?
    func count(#managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> UInt?
}
