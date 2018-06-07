//
//  Query.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct Query<M: NSManagedObject & Entity, R: NSFetchRequestResult> {
    public typealias E = M.CDQIEntityAttribute
    public typealias MakeResult<R> = (E) -> R
    
    internal let entity = E()
    
    internal var fetchLimit: Int = 0
    internal var fetchOffset: Int = 0
    internal var managedObjectContext: NSManagedObjectContext?
    internal var predicates = [NSPredicate]()
    internal var propertiesToFetch = [NSPropertyDescription]()
    internal var propertiesToGroupBy = [NSPropertyDescription]()
    internal var returnsDistinctResults = false
    internal var sortDescriptors = [NSSortDescriptor]()
    
    init() {}
    
    init<R: NSFetchRequestResult>(_ query: Query<M, R>) {
        fetchLimit = query.fetchLimit
        fetchOffset = query.fetchOffset
        managedObjectContext = query.managedObjectContext
        predicates = query.predicates
        propertiesToFetch = query.propertiesToFetch
        propertiesToGroupBy = query.propertiesToGroupBy
        returnsDistinctResults = query.returnsDistinctResults
        sortDescriptors = query.sortDescriptors
    }
    
}
