//
//  QueryBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct QueryBuilder<M: NSManagedObject> {
    public init() {}
    public var fetchLimit: Int = 0
    public var fetchOffset: Int = 0
    public var predicates = [NSPredicate]()
    public var propertiesToFetch: [Any]?
    public var propertiesToGroupBy: [Any]?
    public var resultType: NSFetchRequestResultType = .managedObjectResultType
    public var sortDescriptors = [NSSortDescriptor]()
    public var managedObjectContext: NSManagedObjectContext!
    public var distinct = false
    
    private func request<R>(entity: NSEntityDescription) -> NSFetchRequest<R> {
        let request = NSFetchRequest<R>()
        request.entity = entity
        request.returnsDistinctResults = distinct
        request.fetchLimit = fetchLimit
        request.fetchOffset = fetchOffset
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.sortDescriptors = sortDescriptors
        request.propertiesToFetch = propertiesToFetch
        request.propertiesToGroupBy = propertiesToGroupBy
        request.resultType = resultType
        return request
    }
    
    @available(iOS 10, macOS 10.12, tvOS 10, watchOS 3, *)
    public func request<R>() -> NSFetchRequest<R> {
        return request(entity: M.entity())
    }
    
    public func request<R>(managedObjectModel: NSManagedObjectModel) -> NSFetchRequest<R> {
        return request(entity: M.cdqiEntity(managedObjectModel: managedObjectModel))
    }
}
