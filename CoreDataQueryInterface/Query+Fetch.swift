//
//  Query+Fetch.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public extension Query {
    
    func limit(_ fetchLimit: Int) -> Query<M, R> {
        var query = self
        query.fetchLimit = fetchLimit
        return query
    }
    
    func offset(_ fetchOffset: Int) -> Query<M, R> {
        var query = self
        query.fetchOffset = fetchOffset
        return query
    }
    
    func distinct(_ returnsDistinctResults: Bool = true) -> Query<M, NSDictionary> {
        var query = Query<M, NSDictionary>(self)
        query.returnsDistinctResults = returnsDistinctResults
        return query
    }
    
    func context(_ managedObjectContext: NSManagedObjectContext) -> Query<M, R> {
        var query = self
        query.managedObjectContext = managedObjectContext
        return query
    }
    
    var fetchRequest: NSFetchRequest<R> {
        let fetchRequest = NSFetchRequest<R>()
        fetchRequest.entity = M.entity()
        fetchRequest.fetchLimit = fetchLimit
        fetchRequest.fetchOffset = fetchOffset
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        if propertiesToFetch.count > 0 {
            fetchRequest.propertiesToFetch = propertiesToFetch
        }
        if propertiesToGroupBy.count > 0 {
            fetchRequest.propertiesToGroupBy = propertiesToGroupBy
        }
        if sortDescriptors.count > 0 {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        let resultType: NSFetchRequestResultType
        if R.self is NSDictionary.Type {
            resultType = .dictionaryResultType
        } else if R.self is NSManagedObjectID.Type {
            resultType = .managedObjectIDResultType
        } else {
            resultType = .managedObjectResultType
        }
        fetchRequest.resultType = resultType
        fetchRequest.returnsDistinctResults = returnsDistinctResults
        return fetchRequest
    }
    
    func all(managedObjectContext: NSManagedObjectContext? = nil) throws -> [R] {
        print("PREDICATE: \(fetchRequest.predicate!)")
        if let managedObjectContext = managedObjectContext ?? self.managedObjectContext {
            return try managedObjectContext.fetch(fetchRequest)
        } else {
            return try fetchRequest.execute()
        }
    }
    
    func count(managedObjectContext: NSManagedObjectContext? = nil) throws -> Int {
        print("PREDICATE: \(fetchRequest.predicate!)")
        let managedObjectContext = managedObjectContext ?? self.managedObjectContext!
        return try managedObjectContext.count(for: fetchRequest)
    }
    
    func first(managedObjectContext: NSManagedObjectContext? = nil) throws -> R? {
        let results: [R] = try limit(1).all()
        return results.count == 0 ? nil : results[0]
    }
    
    func exists(managedObjectContext: NSManagedObjectContext? = nil) throws -> Bool {
        return try first(managedObjectContext: managedObjectContext) != nil
    }
    
    func array<T>(_ expression: Property, managedObjectContext: NSManagedObjectContext? = nil, type: T.Type = T.self) throws -> [T] {
        let property = NSExpressionDescription(expression: expression)
        return try dictionaries().reselect().select(property).all(managedObjectContext: managedObjectContext).map{ $0.allValues[0] as! T }
    }
    
    func array<T>(_ make: Make<Property>, managedObjectContext: NSManagedObjectContext? = nil, type: T.Type = T.self) throws -> [T] {
        return try array(make(entity))
    }
    
    func value<T>(_ expression: Property, managedObjectContext: NSManagedObjectContext? = nil, type: T.Type = T.self) throws -> T? {
        return try limit(1).array(expression, managedObjectContext: managedObjectContext).first
    }
    
    func value<T>(_ make: Make<Property>, managedObjectContext: NSManagedObjectContext? = nil, type: T.Type = T.self) throws -> T? {
        return try value(make(entity), managedObjectContext: managedObjectContext)
    }
}
