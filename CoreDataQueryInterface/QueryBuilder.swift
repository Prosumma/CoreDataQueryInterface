//
//  QueryBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct QueryBuilder<E: EntityType> {
    public var managedObjectContext: NSManagedObjectContext?
    public var predicates = [NSPredicate]()
    public var descriptors = [NSSortDescriptor]()
    public var expressions = [ExpressionType]()
    public var groupings = [ExpressionType]()
    public var limit: UInt?
    public var offset: UInt?
    public var returnsDistinctResults: Bool = false
    
    /**
    Creates a new `NSFetchRequest` using the given arguments.
    - parameter resultType: The type of request to create.
    - parameter managedObjectModel: The managed object model to use for metadata. (Used only for expression queries.)
    */
    public func request(resultType: NSFetchRequestResultType, managedObjectModel: NSManagedObjectModel? = nil) -> NSFetchRequest {
        let request = NSFetchRequest(entityName: E.entityName)
        request.resultType = resultType
        if let limit = limit { request.fetchLimit = Int(limit) }
        if let offset = offset { request.fetchOffset = Int(offset) }
        request.returnsDistinctResults = returnsDistinctResults
        if !predicates.isEmpty { request.predicate = NSCompoundPredicate.andPredicateWithSubpredicates(predicates) }
        if !descriptors.isEmpty { request.sortDescriptors = descriptors }
        if !expressions.isEmpty || !groupings.isEmpty {
            let entityDescription = managedObjectModel!.entitiesByName[E.entityName]!
            if !expressions.isEmpty {
                request.propertiesToFetch = expressions.map() { $0.toPropertyDescription(entityDescription) }
            }
            if !groupings.isEmpty {
                request.propertiesToGroupBy = groupings.map() { $0.toPropertyDescription(entityDescription) }
            }
        }
        return request
    }
    
    public func request(resultType: NSFetchRequestResultType, var managedObjectContext: NSManagedObjectContext? = nil) -> NSFetchRequest {
        managedObjectContext = managedObjectContext ?? self.managedObjectContext
        return request(resultType, managedObjectModel: managedObjectContext?.persistentStoreCoordinator?.managedObjectModel)
    }
    
    public func count(var managedObjectContext: NSManagedObjectContext?) throws -> UInt {
        managedObjectContext = managedObjectContext ?? self.managedObjectContext
        var error: NSError?
        let count = managedObjectContext!.countForFetchRequest(self.request(.CountResultType, managedObjectContext: managedObjectContext), error: &error)
        guard error == nil else { throw error! }
        return UInt(count)
    }
    
    public func execute<R: AnyObject>(var managedObjectContext: NSManagedObjectContext?, resultType: NSFetchRequestResultType) throws -> [R] {
        managedObjectContext = managedObjectContext ?? self.managedObjectContext        
        return try managedObjectContext!.executeFetchRequest(self.request(resultType, managedObjectContext: managedObjectContext)) as! [R]
    }
}
