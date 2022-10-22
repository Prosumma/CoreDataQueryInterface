//
//  QueryBuilder+Select.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-22.
//

import CoreData
import Foundation

public extension QueryBuilder {
  internal enum FetchedProperty {
    case string(String)
    case property(NSPropertyDescription)
  }
  
  func select(_ properties: [NSPropertyDescription]) -> QueryBuilder<M, R> {
    select(properties.map(FetchedProperty.property))
  }
  
  func select(_ properties: NSPropertyDescription...) -> QueryBuilder<M, R> {
    select(properties)
  }
  
  func select(_ properties: [String]) -> QueryBuilder<M, R> {
    select(properties.map(FetchedProperty.string))
  }
  
  func select(_ properties: String...) -> QueryBuilder<M, R> {
    select(properties)
  }
  
  func select<V>(_ keyPath: KeyPath<M, V>) -> QueryBuilder<M, R> {
    guard let keyPathString = keyPath._kvcKeyPathString else {
      preconditionFailure("\(keyPath) is not valid for Key-Value Coding.")
    }
    return select(keyPathString)
  }
  
  func select<V1, V2>(
    _ keyPath1: KeyPath<M, V1>,
    _ keyPath2: KeyPath<M, V2>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
  }
  
  func select<V1, V2, V3>(
    _ keyPath1: KeyPath<M, V1>,
    _ keyPath2: KeyPath<M, V2>,
    _ keyPath3: KeyPath<M, V3>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
  }
  
  func select<V1, V2, V3, V4>(
    _ keyPath1: KeyPath<M, V1>,
    _ keyPath2: KeyPath<M, V2>,
    _ keyPath3: KeyPath<M, V3>,
    _ keyPath4: KeyPath<M, V4>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
      .select(keyPath4)
  }
  
  private func select(_ properties: [FetchedProperty]) -> QueryBuilder<M, R> {
    var query = self
    query.propertiesToFetch.append(contentsOf: properties)
    return query
  }
}

