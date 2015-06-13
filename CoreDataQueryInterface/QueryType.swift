//
//  QueryType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol QueryType {
    typealias QueryEntityType: EntityType
    typealias QueryResultType: AnyObject
    
    init(builder: QueryBuilder<QueryEntityType>)
    var builder: QueryBuilder<QueryEntityType> { get }
    var resultType: NSFetchRequestResultType { get }
}

extension QueryType {
    public static func from(QueryEntityType.Type) -> Self {
        return self(builder: QueryBuilder())
    }
    public func context(managedObjectContext: NSManagedObjectContext) -> Self {
        var builder = self.builder
        builder.managedObjectContext = managedObjectContext
        return Self(builder: builder)
    }
}
