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

  func select<V1, V2, V3, V4, V5>(
    _ keyPath1: KeyPath<M, V1>,
    _ keyPath2: KeyPath<M, V2>,
    _ keyPath3: KeyPath<M, V3>,
    _ keyPath4: KeyPath<M, V4>,
    _ keyPath5: KeyPath<M, V5>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
      .select(keyPath4)
      .select(keyPath5)
  }

  func select<V1, V2, V3, V4, V5, V6>(
    _ keyPath1: KeyPath<M, V1>,
    _ keyPath2: KeyPath<M, V2>,
    _ keyPath3: KeyPath<M, V3>,
    _ keyPath4: KeyPath<M, V4>,
    _ keyPath5: KeyPath<M, V5>,
    _ keyPath6: KeyPath<M, V6>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
      .select(keyPath4)
      .select(keyPath5)
      .select(keyPath6)
  }

  func select<V1, V2, V3, V4, V5, V6, V7>(
    _ keyPath1: KeyPath<M, V1>,
    _ keyPath2: KeyPath<M, V2>,
    _ keyPath3: KeyPath<M, V3>,
    _ keyPath4: KeyPath<M, V4>,
    _ keyPath5: KeyPath<M, V5>,
    _ keyPath6: KeyPath<M, V6>,
    _ keyPath7: KeyPath<M, V7>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
      .select(keyPath4)
      .select(keyPath5)
      .select(keyPath6)
      .select(keyPath7)
  }
  
  private func select(_ properties: [FetchedProperty]) -> QueryBuilder<M, R> {
    var query = self
    query.propertiesToFetch.append(contentsOf: properties)
    return query
  }
}

