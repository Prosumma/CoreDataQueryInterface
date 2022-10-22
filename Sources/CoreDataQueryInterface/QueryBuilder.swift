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
  var propertiesToFetch: [FetchedProperty] = []
  
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
    if !propertiesToFetch.isEmpty {
      let properties: [Any] = propertiesToFetch.map {
        switch $0 {
        case .string(let property):
          return property
        case .property(let property):
          return property
        }
      }
      fetchRequest.propertiesToFetch = properties
    }
    return fetchRequest
  }
}

public func Query<M: NSManagedObject>(_ entityType: M.Type) -> QueryBuilder<M, M> {
  .init()
}
