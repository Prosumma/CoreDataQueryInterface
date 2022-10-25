//
//  QueryBuilder+Group.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-24.
//

import PredicateQI
import XCTest

public extension QueryBuilder {
  func group(by properties: [NSPropertyDescription]) -> QueryBuilder<M, R> {
    group(by: properties.map(FetchedProperty.property))
  }
  
  func group(by properties: NSPropertyDescription...) -> QueryBuilder<M, R> {
    group(by: properties)
  }
  
  func group(by properties: [String]) -> QueryBuilder<M, R> {
    group(by: properties.map(FetchedProperty.string))
  }
  
  func group(by properties: String...) -> QueryBuilder<M, R> {
    group(by: properties)
  }
  
  func group<V: E>(by keyPath: KeyPath<O, V>, name: String, type: NSAttributeDescription.AttributeType) -> QueryBuilder<M, R> {
    return group(by: NSExpressionDescription(objectKeyPath: keyPath, name: name, type: type))
  }
  
  func group<V: E>(by keyPath: KeyPath<O, V>) -> QueryBuilder<M, R> {
    let object = O()
    let expression = object[keyPath: keyPath]
    return group(by: "\(expression.pqiExpression)")
  }

  func group<V1: E, V2: E>(
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
  }

  func group<V1: E, V2: E, V3: E>(
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
      .group(by: keyPath3)
  }

  func group<V1: E, V2: E, V3: E, V4: E>(
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
      .group(by: keyPath3)
      .group(by: keyPath4)
  }

  func group<V1: E, V2: E, V3: E, V4: E, V5: E>(
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>,
    _ keyPath5: KeyPath<O, V5>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
      .group(by: keyPath3)
      .group(by: keyPath4)
      .group(by: keyPath5)
  }

  func group<V1: E, V2: E, V3: E, V4: E, V5: E, V6: E>(
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>,
    _ keyPath5: KeyPath<O, V5>,
    _ keyPath6: KeyPath<O, V6>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
      .group(by: keyPath3)
      .group(by: keyPath4)
      .group(by: keyPath5)
      .group(by: keyPath6)
  }

  func group<V1: E, V2: E, V3: E, V4: E, V5: E, V6: E, V7: E>(
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>,
    _ keyPath5: KeyPath<O, V5>,
    _ keyPath6: KeyPath<O, V6>,
    _ keyPath7: KeyPath<O, V7>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
      .group(by: keyPath3)
      .group(by: keyPath4)
      .group(by: keyPath5)
      .group(by: keyPath6)
      .group(by: keyPath7)
  }

  private func group(by properties: [FetchedProperty]) -> QueryBuilder<M, R> {
    var query = self
    query.propertiesToGroupBy.append(contentsOf: properties)
    return query
  }
}
