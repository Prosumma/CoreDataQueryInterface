//
//  QueryBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct QueryBuilder<M: NSManagedObject> where M: Entity {
    public init() {}
    public var fetchLimit: Int = 0 // Is this the right default?
    public var predicates = [NSPredicate]()
    public var properties = [Any]()
    public var propertiesToGroupBy = [Any]()
    public var resultType: NSFetchRequestResultType = .managedObjectResultType
    public var sortDescriptors = [NSSortDescriptor]()
    public var managedObjectContext: NSManagedObjectContext!
    
    func request<R>() -> NSFetchRequest<R> {
        let request = NSFetchRequest<R>()
        request.fetchLimit = fetchLimit
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        if properties.count > 0 {
            request.propertiesToFetch = properties
        }
        if propertiesToGroupBy.count > 0 {
            request.propertiesToGroupBy = propertiesToGroupBy
        }
        //        request.resultType = resultType
        return request
    }
}
