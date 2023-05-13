//
//  QueryBuilder+Select.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-22.
//

import CoreData
import Foundation
import PredicateQI

public extension QueryBuilder {
  func distinct(_ returnsDistinctResults: Bool = true) -> QueryBuilder<M, R> {
    var query = self
    query.returnsDistinctResults = returnsDistinctResults
    return query
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
  
  func select<V: E>(_ keyPath: KeyPath<O, V>, name: String? = nil, type: NSAttributeDescription.AttributeType? = nil) -> QueryBuilder<M, R> {
    select(NSExpressionDescription(objectKeyPath: keyPath, name: name, type: type))
  }
  
  func select<V1: E, V2: E>(
    _ keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
  }

  func select<V1: E, V2: E, V3: E>(
    _ keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
  }

  func select<V1: E, V2: E, V3: E, V4: E>(
    _ keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
      .select(keyPath4)
  }

  func select<V1: E, V2: E, V3: E, V4: E, V5: E>(
    _ keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>,
    _ keyPath5: KeyPath<O, V5>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
      .select(keyPath4)
      .select(keyPath5)
  }

  func select<V1: E, V2: E, V3: E, V4: E, V5: E, V6: E>(
    _ keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>,
    _ keyPath5: KeyPath<O, V5>,
    _ keyPath6: KeyPath<O, V6>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
      .select(keyPath4)
      .select(keyPath5)
      .select(keyPath6)
  }

  func select<V1: E, V2: E, V3: E, V4: E, V5: E, V6: E, V7: E>(
    _ keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>,
    _ keyPath5: KeyPath<O, V5>,
    _ keyPath6: KeyPath<O, V6>,
    _ keyPath7: KeyPath<O, V7>
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
