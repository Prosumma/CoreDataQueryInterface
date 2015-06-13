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
    public var expressions = [NSExpressionDescription]() // TODO: Change this
    public var limit: UInt?
    
    public func request(resultType: NSFetchRequestResultType) -> NSFetchRequest {
        let request = NSFetchRequest(entityName: E.entityName)
        request.resultType = resultType
        if let limit = limit { request.fetchLimit = Int(limit) }
        if !predicates.isEmpty { request.predicate = NSCompoundPredicate.andPredicateWithSubpredicates(predicates) }
        if !descriptors.isEmpty && (resultType == .ManagedObjectResultType || resultType == .ManagedObjectIDResultType) {
            request.sortDescriptors = descriptors
        }
        return request
    }
    
    public func count(var managedObjectContext: NSManagedObjectContext?) throws -> UInt {
        managedObjectContext = managedObjectContext ?? self.managedObjectContext
        var error: NSError?
        let count = managedObjectContext!.countForFetchRequest(self.request(.CountResultType), error: &error)
        guard error == nil else { throw error! }
        return UInt(count)
    }
    
    public func execute<R: AnyObject>(var managedObjectContext: NSManagedObjectContext?, resultType: NSFetchRequestResultType) throws -> [R] {
        managedObjectContext = managedObjectContext ?? self.managedObjectContext
        return try managedObjectContext!.executeFetchRequest(self.request(resultType)) as! [R]
    }
}
