//
//  ManagedObjectIDQuery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct ManagedObjectIDQuery<E: EntityType> : QueryType {
    typealias QueryResultType = NSManagedObjectID
    public let builder: QueryBuilder<E>
    public init(builder: QueryBuilder<E>) {
        self.builder = builder
    }
    public let resultType = NSFetchRequestResultType.ManagedObjectIDResultType
}