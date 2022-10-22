//
//  QueryBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-21.
//

import CoreData
import PredicateQI

public struct QueryBuilder<M: NSManagedObject, R: NSFetchRequestResult> {
  private weak var managedObjectContext: NSManagedObjectContext?
  private var predicates: [NSPredicate] = []
  
  public func context(_ moc: NSManagedObjectContext) -> QueryBuilder<M, R> {
    var query = self
    query.managedObjectContext = moc
    return query
  }
  
  public func filter(_ predicate: NSPredicate) -> QueryBuilder<M, R> {
    var query = self
    query.predicates.append(predicate)
    return query
  }
  
  public func filter(_ format: String, _ args: Any...) -> QueryBuilder<M, R> {
    filter(NSPredicate(format: format, argumentArray: args))
  }
  
  public func filter(_ isIncluded: (Object<M>) -> PredicateBuilder) -> QueryBuilder<M, R> {
    filter(pred(isIncluded(.init())))
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
