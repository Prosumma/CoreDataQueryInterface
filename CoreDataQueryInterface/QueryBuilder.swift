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
    public var properties: [Any]?
    public var propertiesToGroupBy: [Any]?
    public var resultType: NSFetchRequestResultType = .managedObjectResultType
    public var sortDescriptors = [NSSortDescriptor]()
    public var managedObjectContext: NSManagedObjectContext!
    public var distinct = false
    
    func request<R>(managedObjectModel: NSManagedObjectModel? = nil) -> NSFetchRequest<R> {
        let request = NSFetchRequest<R>()
        request.entity = M.cdqiEntity(managedObjectModel: managedObjectModel)
        request.returnsDistinctResults = distinct
        request.fetchLimit = fetchLimit
        request.fetchOffset = fetchOffset
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.sortDescriptors = sortDescriptors
        request.propertiesToFetch = properties
        request.propertiesToGroupBy = propertiesToGroupBy
        request.resultType = resultType
        NSLog("%@", request)
        return request
    }
}
