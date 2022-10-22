//
//  QueryBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-21.
//

import CoreData
import PredicateQI

public struct QueryBuilder<M: NSManagedObject, R: NSFetchRequestResult> {
  weak var managedObjectContext: NSManagedObjectContext?
  var predicates: [NSPredicate] = []
  var sortDescriptors: [NSSortDescriptor] = []
  
  public func context(_ moc: NSManagedObjectContext) -> QueryBuilder<M, R> {
    var query = self
    query.managedObjectContext = moc
    return query
  }
  
  public var fetchRequest: NSFetchRequest<R> {
    let fetchRequest = NSFetchRequest<R>(entityName: M.entity().name!)
    if !predicates.isEmpty {
      fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
    return fetchRequest
  }
}

public func Query<M: NSManagedObject>(_ entityType: M.Type) -> QueryBuilder<M, M> {
  .init()
}
