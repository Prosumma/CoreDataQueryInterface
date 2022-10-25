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
  var fetchLimit: Int = 0
  var fetchOffset: Int = 0
  var predicates: [NSPredicate] = []
  var sortDescriptors: [NSSortDescriptor] = []
  var propertiesToFetch: [FetchedProperty] = []
  var returnsDistinctResults = false
  
  init() {}
  
  init<R2>(copying query: QueryBuilder<M, R2>) {
    managedObjectContext = query.managedObjectContext
    predicates = query.predicates
    sortDescriptors = query.sortDescriptors
    propertiesToFetch = query.propertiesToFetch
    returnsDistinctResults = query.returnsDistinctResults
  }
  
  public func context(_ moc: NSManagedObjectContext) -> QueryBuilder<M, R> {
    var query = self
    query.managedObjectContext = moc
    return query
  }
  
  /**
   Resets the set of the receiver so that it can be filtered,
   ordered, etc. again.
   
   ```swift
   let query1 = Query(Person.self).filter { $0.name == "Bob" }
   let query2 = query1.re(.filter).filter { $0.name == "Fred" }
   ```
   
   The `filter` function is cumulative. Each new application of it
   adds a new filter (implicitly using the AND conjunction). Calling
   `re(.filter)` erases all previous filters, allowing new ones to
   be added.
   */
  public func re(_ states: [QueryBuilderState]) -> QueryBuilder<M, R> {
    var query = self
    for state in states {
      switch state {
      case .filter:
        query.predicates = []
      case .order:
        query.sortDescriptors = []
      case .select:
        query.propertiesToFetch = []
      }
    }
    return query
  }
  
  public func re(_ states: QueryBuilderState...) -> QueryBuilder<M, R> {
    re(states)
  }
}

/**
 This function is called the "Query Constructor". Use it to
 start a new query.
 
 ```swift
 Query(Person.self).filter { $0.lastName == "Smith" }
 ```
 
 - Note: This function is deliberately capitalized to mimic a constructor.
 */
public func Query<M: NSManagedObject>(_ entityType: M.Type) -> QueryBuilder<M, M> {
  .init()
}

public enum QueryBuilderState: CaseIterable {
  case filter, order, select
}
