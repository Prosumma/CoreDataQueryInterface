//
//  QueryBuilder+Fetch.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-22.
//

import CoreData

public extension QueryBuilder {
  var fetchRequest: NSFetchRequest<R> {
    let fetchRequest = NSFetchRequest<R>(entityName: M.entity().name!)
    fetchRequest.returnsDistinctResults = returnsDistinctResults
    fetchRequest.fetchLimit = fetchLimit
    fetchRequest.fetchOffset = fetchOffset
    if !predicates.isEmpty {
      fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
    if !propertiesToFetch.isEmpty {
      let properties = propertiesToFetch.map(\.asAny)
      fetchRequest.propertiesToFetch = properties
    }
    if !propertiesToGroupBy.isEmpty {
      let properties = propertiesToGroupBy.map(\.asAny)
      fetchRequest.propertiesToGroupBy = properties
    }
    if !sortDescriptors.isEmpty {
      fetchRequest.sortDescriptors = sortDescriptors
    }
    let resultType: NSFetchRequestResultType
    switch R.self {
    case is NSManagedObject.Type:
      resultType = .managedObjectResultType
    case is NSManagedObjectID.Type:
      resultType = .managedObjectIDResultType
    case is NSDictionary.Type:
      resultType = .dictionaryResultType
    case is NSNumber.Type:
      // TODO: Figure out what the hell this is.
      resultType = .countResultType // ???
    default:
      resultType = .managedObjectResultType
    }
    fetchRequest.resultType = resultType
    return fetchRequest
  }
  
  func limit(_ fetchLimit: Int) -> QueryBuilder<M, R> {
    var query = self
    query.fetchLimit = fetchLimit
    return query
  }
  
  func offset(_ fetchOffset: Int) -> QueryBuilder<M, R> {
    var query = self
    query.fetchOffset = fetchOffset
    return query
  }
  
  func objects() -> QueryBuilder<M, M> {
    .init(copying: self)
  }
  
  func ids() -> QueryBuilder<M, NSManagedObjectID> {
    .init(copying: self)
  }
  
  func dictionaries() -> QueryBuilder<M, NSDictionary> {
    .init(copying: self)
  }
 
  func fetch(_ managedObjectContext: NSManagedObjectContext? = nil) throws -> [R] {
    let results: [R]
    if let moc = self.managedObjectContext ?? managedObjectContext {
      results = try moc.fetch(fetchRequest)
    } else {
      results = try fetchRequest.execute()
    }
    return results
  }
  
  func fetchObjects(_ managedObjectContext: NSManagedObjectContext? = nil) throws -> [M] {
    try objects().fetch(managedObjectContext)
  }
  
  func fetchIDs(_ managedObjectContext: NSManagedObjectContext? = nil) throws -> [NSManagedObjectID] {
    try ids().fetch(managedObjectContext)
  }
  
  func fetchDictionaries(_ managedObjectContext: NSManagedObjectContext? = nil) throws -> [[String: Any]] {
    try dictionaries().fetch(managedObjectContext) as! [[String: Any]]
  }
  
  func count(_ managedObjectContext: NSManagedObjectContext? = nil) throws -> Int {
    guard let moc = self.managedObjectContext ?? managedObjectContext else {
      preconditionFailure("No NSManagedObjectContext instance on which to execute the request.")
    }
    return try moc.count(for: fetchRequest)
  }
}
