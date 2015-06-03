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
public protocol QueryType: SequenceType {
    
    typealias EntityType: ManagedObjectType
    typealias ResultQueryType
    typealias ResultType
    
    static func from(EntityType.Type) -> ResultQueryType
    
    func context(managedObjectContext: NSManagedObjectContext) -> ResultQueryType
    func filter(predicate: NSPredicate) -> ResultQueryType
    func filter(format: String, argumentArray: [AnyObject]?) -> ResultQueryType
    func filter(format: String, _ args: CVarArgType...) -> ResultQueryType
    func filter(predicate: EntityType.ManagedObjectAttributeType -> NSPredicate) -> ResultQueryType
    func limit(limit: UInt) -> ResultQueryType
    func offset(offset: UInt) -> ResultQueryType
    func order(descriptors: [NSSortDescriptor]) -> ResultQueryType
    func order(descriptors: NSSortDescriptor...) -> ResultQueryType
    func order(descriptors: String...) -> ResultQueryType
    func order(descending descriptors: String...) -> ResultQueryType
    func order(attributes: [Attribute]) -> ResultQueryType
    func order(attributes: Attribute...) -> ResultQueryType
    func order(descending attributes: [Attribute]) -> ResultQueryType
    func order(descending attributes: Attribute...) -> ResultQueryType
    
    func all(#managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> [ResultType]?
    func first(#managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> ResultType?
    func count(#managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> UInt?
    
    func request() -> NSFetchRequest
}
