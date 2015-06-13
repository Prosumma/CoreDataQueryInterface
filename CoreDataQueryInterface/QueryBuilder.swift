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
    
    public func request(resultType: NSFetchRequestResultType) -> NSFetchRequest {
        return NSFetchRequest()
    }
    
    public func execute<R: AnyObject>(var managedObjectContext: NSManagedObjectContext?, resultType: NSFetchRequestResultType) throws -> [R] {
        managedObjectContext = managedObjectContext ?? self.managedObjectContext
        return try managedObjectContext!.executeFetchRequest(self.request(resultType)) as! [R]
    }
}
