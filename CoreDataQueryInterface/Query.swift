//
//  Query.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/10/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct Query<E: EntityMetadata where E: AnyObject>: SequenceType {
    
    public var predicates = [NSPredicate]()
    public var fetchLimit: UInt = 0
    public var fetchOffset: UInt = 0
    public var sortDescriptors = [AnyObject]()
    public var managedObjectContext: NSManagedObjectContext!
    
    private var request: NSFetchRequest {
        let request = NSFetchRequest(entityName: E.entityName)
        switch predicates.count {
        case 0: break
        case 1: request.predicate = predicates[0]
        default: request.predicate = NSCompoundPredicate(type: .AndPredicateType, subpredicates: predicates)
        }
        request.fetchLimit =  Int(fetchLimit)
        request.fetchOffset = Int(fetchOffset)
        request.sortDescriptors = sortDescriptors.count == 0 ? nil : sortDescriptors
        return request
    }
    
    // MARK: Query Interface
    
    public static func from(E.Type) -> Query<E> {
        return Query<E>()
    }
    
    public func context(managedObjectContext: NSManagedObjectContext) -> Query<E> {
        var query = self
        query.managedObjectContext = managedObjectContext
        return query
    }
    
    public func filter(predicate: NSPredicate) -> Query<E> {
        var query = self
        query.predicates.append(predicate)
        return query
    }
    
    public func filter(format: String, arguments: CVaListPointer) -> Query<E> {
        var query = self
        query.predicates.append(NSPredicate(format: format, arguments: arguments))
        return query
    }
    
    public func filter(format: String, argumentArray: [AnyObject]?) -> Query<E> {
        var query = self
        query.predicates.append(NSPredicate(format: format, argumentArray: argumentArray))
        return query
    }
    
    public func filter(format: String, _ args: CVarArgType...) -> Query<E> {
        return withVaList(args) {
            var query = self
            query.predicates.append(NSPredicate(format: format, arguments: $0))
            return query
        }
    }
    
    public func limit(limit: UInt) -> Query<E> {
        var query = self
        query.fetchLimit = limit
        return query
    }
    
    public func offset(offset: UInt) -> Query<E> {
        var query = self
        query.fetchOffset = offset
        return query
    }
    
    public func order(sortDescriptors: [AnyObject]) -> Query<E> {
        var query = self
        query.sortDescriptors = query.sortDescriptors + sortDescriptors.map() { $0 is String ? NSSortDescriptor(key: $0 as! String, ascending: true) : $0 }
        return query
    }
    
    public func order(sortDescriptors: AnyObject...) -> Query<E> {
        return order(sortDescriptors)
    }
    
    public func all(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> [E]? {
        return (managedObjectContext ?? self.managedObjectContext)!.executeFetchRequest(request, error: error) as! [E]?
    }
    
    public func first(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> E? {
        return limit(1).all(managedObjectContext: managedObjectContext, error: error)?.first
    }
    
    public func count(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> UInt? {
        let recordCount = (managedObjectContext ?? self.managedObjectContext)!.countForFetchRequest(request, error: error)
        return recordCount == NSNotFound ? nil : UInt(recordCount)
    }
    
    // MARK: SequenceType
    
    private func generate(error: NSErrorPointer) -> GeneratorOf<E> {
        if let objects = all(error: error) {
            return GeneratorOf(objects.generate())
        } else {
            return GeneratorOf() { nil }
        }
    }
    
    public func generate() -> GeneratorOf<E> {
        return generate(nil)
    }
    
}