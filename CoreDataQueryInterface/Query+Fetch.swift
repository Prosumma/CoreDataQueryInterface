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
    
    /**
     Sets the fetch limit, the maximum number of records to be fetched.
     
     The default is to fetch all records. To set the fetch limit back
     to the default, call `limit(0)` or call `unlimit()`.
     */
    func limit(_ fetchLimit: Int) -> Query<M, R> {
        var query = self
        query.fetchLimit = fetchLimit
        return query
    }
    
    /**
     Convenience method to remove the fetch limit.
     
     Same as `limit(0)`.
     */
    func unlimit() -> Query<M, R> {
        return limit(0)
    }
    
    /**
     Sets the fetch offset. The default is 0.
     */
    func offset(_ fetchOffset: Int) -> Query<M, R> {
        var query = self
        query.fetchOffset = fetchOffset
        return query
    }
    
    /**
     Whether or not to return distinct results.
     
     - note: This changes the fetch result type to `NSDictionary`. Distinct
     results does not apply to fetched entities.
     */
    func distinct(_ returnsDistinctResults: Bool = true) -> Query<M, NSDictionary> {
        var query = Query<M, NSDictionary>(self)
        query.returnsDistinctResults = returnsDistinctResults
        return query
    }
    
    /**
     Sets the default managed object context for the current query.
     Call `context(nil)` to remove the default managed object context.
     
     - warning: The managed object context is referenced weakly.
     */
    func context(_ managedObjectContext: NSManagedObjectContext?) -> Query<M, R> {
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
        switch R.self {
        case is NSDictionary.Type: resultType = .dictionaryResultType
        case is NSManagedObjectID.Type: resultType = .managedObjectIDResultType
        default: resultType = .managedObjectResultType
        }
        fetchRequest.resultType = resultType
        fetchRequest.returnsDistinctResults = returnsDistinctResults
        return fetchRequest
    }
    
    /**
     Executes the current query and returns its results.
     
     - warning: If no managed object context is passed to this method, the managed
     object context associated with the current query is used. If no managed object
     context is associated with the current query, the managed object context
     associated with the current queue is used. If no managed object context
     is associated with the current queue, an unrecoverable runtime exception
     will occur.
    */
    func all(managedObjectContext: NSManagedObjectContext? = nil) throws -> [R] {
        if let managedObjectContext = managedObjectContext ?? self.managedObjectContext {
            return try managedObjectContext.fetch(fetchRequest)
        } else {
            return try fetchRequest.execute()
        }
    }
    
    /**
     Returns the count of query results.
     
     - warning: If no managed object context is passed to this method, the managed
     object context associated with the current query is used. If no managed object
     context is associated with the current query, the managed object context
     associated with the current queue is used. If no managed object context
     is associated with the current queue, an unrecoverable runtime exception
     will occur.
     */
    func count(managedObjectContext: NSManagedObjectContext? = nil) throws -> Int {
        let managedObjectContext = managedObjectContext ?? self.managedObjectContext!
        return try managedObjectContext.count(for: fetchRequest)
    }
    
    /**
     Executes the current query and returns its first result, or `nil` if there
     are no results.
     
     - warning: If no managed object context is passed to this method, the managed
     object context associated with the current query is used. If no managed object
     context is associated with the current query, the managed object context
     associated with the current queue is used. If no managed object context
     is associated with the current queue, an unrecoverable runtime exception
     will occur.
    */
    func first(managedObjectContext: NSManagedObjectContext? = nil) throws -> R? {
        let results: [R] = try limit(1).all()
        return results.count == 0 ? nil : results[0]
    }
    
    /**
     Executes the current query and returns `true` if any entities exist
     which match the query.
     
     - warning: If no managed object context is passed to this method, the managed
     object context associated with the current query is used. If no managed object
     context is associated with the current query, the managed object context
     associated with the current queue is used. If no managed object context
     is associated with the current queue, an unrecoverable runtime exception
     will occur.
    */
    func exists(managedObjectContext: NSManagedObjectContext? = nil) throws -> Bool {
        return try first(managedObjectContext: managedObjectContext) != nil
    }
    
    /**
     Executes the current query and returns an array of the property specified
     in the `expression` parameter cast to type `T`.
     
     For example, lets say we have an entity called `Person`, containing an
     `age` property. We want an array of just these ages, ignoring all the other
     properties of a person.
     
     ```
     let ages: [Int] = try managedObjectContext
                        .from(Person.self)
                        .array(Person.e.age)
     ```
     
     - warning: If no managed object context is passed to this method, the managed
     object context associated with the current query is used. If no managed object
     context is associated with the current query, the managed object context
     associated with the current queue is used. If no managed object context
     is associated with the current queue, an unrecoverable runtime exception
     will occur.
    */
    func array<T>(_ expression: Property, managedObjectContext: NSManagedObjectContext? = nil, type: T.Type = T.self) throws -> [T] {
        let property = NSExpressionDescription(expression: expression)
        return try items.reselect().select(property).all(managedObjectContext: managedObjectContext).map{ $0.allValues[0] as! T }
    }
    
    /**
     Executes the current query and returns an array of the property specified
     in the `expression` parameter cast to type `T`.
     
     For example, lets say we have an entity called `Person`, containing an
     `age` property. We want an array of just these ages, ignoring all the other
     properties of a person.
     
     ```
     let ages: [Int] = try managedObjectContext
                        .from(Person.self)
                        .array({ $0.age })
     ```
     
     - warning: If no managed object context is passed to this method, the managed
     object context associated with the current query is used. If no managed object
     context is associated with the current query, the managed object context
     associated with the current queue is used. If no managed object context
     is associated with the current queue, an unrecoverable runtime exception
     will occur.
     */
    func array<T>(_ make: MakeResult<Property>, managedObjectContext: NSManagedObjectContext? = nil, type: T.Type = T.self) throws -> [T] {
        return try array(make(entity))
    }
    
    /**
     Executes the current query and returns the first value of the property specified by
     `expression`.
     
     For example, lets say we have an entity called `Person`, and we want only the age
     of a particular person. We know in advance that we have no duplicates based on name:
     
     ```
     let age: Int = try managedObjectContext
                    .from(Person.self)
                    .filter(Person.e.firstName = "Eric" && Person.e.lastName == "Idle")
                    .value(Person.e.age)
     ```
     
     - warning: If no managed object context is passed to this method, the managed
     object context associated with the current query is used. If no managed object
     context is associated with the current query, the managed object context
     associated with the current queue is used. If no managed object context
     is associated with the current queue, an unrecoverable runtime exception
     will occur.
    */
    func value<T>(_ expression: Property, managedObjectContext: NSManagedObjectContext? = nil, type: T.Type = T.self) throws -> T? {
        return try limit(1).array(expression, managedObjectContext: managedObjectContext).first
    }
    
    /**
     Executes the current query and returns the first value of the property specified by
     `expression`.
     
     For example, lets say we have an entity called `Person`, and we want only the age
     of a particular person. We know in advance that we have no duplicates based on name:
     
     ```
     let age: Int = try managedObjectContext
                     .from(Person.self)
                     .filter(Person.e.firstName == "Eric" && Person.e.lastName == "Idle")
                     .value({ $0.age })
     ```
     
     - warning: If no managed object context is passed to this method, the managed
     object context associated with the current query is used. If no managed object
     context is associated with the current query, the managed object context
     associated with the current queue is used. If no managed object context
     is associated with the current queue, an unrecoverable runtime exception
     will occur.
     */
    func value<T>(_ make: MakeResult<Property>, managedObjectContext: NSManagedObjectContext? = nil, type: T.Type = T.self) throws -> T? {
        return try value(make(entity), managedObjectContext: managedObjectContext)
    }
}
