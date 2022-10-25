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
  
  func group<V: Expression>(by keyPath: KeyPath<Object<M>, V>, name: String, type: NSAttributeDescription.AttributeType) -> QueryBuilder<M, R> {
    return group(by: NSExpressionDescription(objectKeyPath: keyPath, name: name, type: type))
  }
  
  func group<V: Expression>(by keyPath: KeyPath<Object<M>, V>) -> QueryBuilder<M, R> {
    let object = Object<M>()
    let expression = object[keyPath: keyPath]
    return group(by: "\(expression.pqiExpression)")
  }

  func group<V1: Expression, V2: Expression>(
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
  }

  func group<V1: Expression, V2: Expression, V3: Expression>(
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
      .group(by: keyPath3)
  }

  func group<V1: Expression, V2: Expression, V3: Expression, V4: Expression>(
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
      .group(by: keyPath3)
      .group(by: keyPath4)
  }

  func group<V1: Expression, V2: Expression, V3: Expression, V4: Expression, V5: Expression>(
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>,
    _ keyPath5: KeyPath<Object<M>, V5>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
      .group(by: keyPath3)
      .group(by: keyPath4)
      .group(by: keyPath5)
  }

  func group<V1: Expression, V2: Expression, V3: Expression, V4: Expression, V5: Expression, V6: Expression>(
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>,
    _ keyPath5: KeyPath<Object<M>, V5>,
    _ keyPath6: KeyPath<Object<M>, V6>
  ) -> QueryBuilder<M, R> {
    group(by: keyPath1)
      .group(by: keyPath2)
      .group(by: keyPath3)
      .group(by: keyPath4)
      .group(by: keyPath5)
      .group(by: keyPath6)
  }

  func group<V1: Expression, V2: Expression, V3: Expression, V4: Expression, V5: Expression, V6: Expression, V7: Expression>(
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>,
    _ keyPath5: KeyPath<Object<M>, V5>,
    _ keyPath6: KeyPath<Object<M>, V6>,
    _ keyPath7: KeyPath<Object<M>, V7>
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
