//
//  QueryType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol QueryType: SequenceType {
    typealias QueryEntityType: EntityType
    typealias QueryResultType: AnyObject
    
    init(builder: QueryBuilder<QueryEntityType>)
    var builder: QueryBuilder<QueryEntityType> { get }
    var resultType: NSFetchRequestResultType { get }
}

extension QueryType {
    /**
    Starts a new query of the given type.
    */
    public static func from(_: QueryEntityType.Type) -> Self {
        return self.init(builder: QueryBuilder<QueryEntityType>())
    }
    
    /**
    Sets the managed object context.
    */
    public func context(managedObjectContext: NSManagedObjectContext) -> Self {
        var builder = self.builder
        builder.managedObjectContext = managedObjectContext
        return Self(builder: builder)
    }
    
    /**
    Limit the query to a certain number of records.
    */
    public func limit(limit: UInt?) -> Self {
        var builder = self.builder
        builder.limit = limit
        return Self(builder: builder)
    }
    
    /**
    Start the query at a certain offset.
    */
    public func offset(offset: UInt?) -> Self {
        var builder = self.builder
        builder.offset = offset
        return Self(builder: builder)
    }
}
