//
//  ManagedObjectIDQuery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/**
A query whose result type is `NSManagedObjectID`.
*/
public struct ManagedObjectIDQuery<E: EntityType> : QueryType {
    public typealias QueryResultType = NSManagedObjectID
    public let builder: QueryBuilder<E>
    public init(builder: QueryBuilder<E>) {
        self.builder = builder
    }
    public let resultType = NSFetchRequestResultType.ManagedObjectIDResultType
}