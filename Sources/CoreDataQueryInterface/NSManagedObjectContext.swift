//
//  NSManagedObjectContext.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-22.
//

import CoreData

public extension NSManagedObjectContext {
  func query<M: NSManagedObject>(_ entityType: M.Type) -> QueryBuilder<M, M> {
    Query(entityType).context(self)
  }
}
