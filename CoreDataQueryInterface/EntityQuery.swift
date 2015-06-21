//
//  EntityQuery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/**
A query that returns entities, i.e., managed objects. Can be converted
to an expression query by using one of the `ExpressionQueryType`
methods, such as `select()`. Can be converted to `ManagedObjectIDQuery` by using the
`objectIDs()` method.
*/
public struct EntityQuery<E: EntityType> : ExpressionQueryType {
    typealias QueryResultType = E
    public let builder: QueryBuilder<E>
    public init(builder: QueryBuilder<E>) {
        self.builder = builder
    }
    public let resultType = NSFetchRequestResultType.ManagedObjectResultType
    public func objectIDs() -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery(builder: builder)
    }
}