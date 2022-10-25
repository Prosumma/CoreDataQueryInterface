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
  
  func select<V: Expression>(_ keyPath: KeyPath<Object<M>, V>, name: String, type: NSAttributeDescription.AttributeType) -> QueryBuilder<M, R> {
    let description = NSExpressionDescription()
    description.expression = Object<M>()[keyPath: keyPath].pqiExpression
    description.resultType = type
    description.name = name
    return select(description)
  }
  
  func select<V: Expression>(_ keyPath: KeyPath<Object<M>, V>) -> QueryBuilder<M, R> {
    let object = Object<M>()
    let expression = object[keyPath: keyPath]
    return select("\(expression.pqiExpression)")
  }

  func select<V1: Expression, V2: Expression>(
    _ keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
  }

  func select<V1: Expression, V2: Expression, V3: Expression>(
    _ keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
  }

  func select<V1: Expression, V2: Expression, V3: Expression, V4: Expression>(
    _ keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
      .select(keyPath4)
  }

  func select<V1: Expression, V2: Expression, V3: Expression, V4: Expression, V5: Expression>(
    _ keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>,
    _ keyPath5: KeyPath<Object<M>, V5>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
      .select(keyPath4)
      .select(keyPath5)
  }

  func select<V1: Expression, V2: Expression, V3: Expression, V4: Expression, V5: Expression, V6: Expression>(
    _ keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>,
    _ keyPath5: KeyPath<Object<M>, V5>,
    _ keyPath6: KeyPath<Object<M>, V6>
  ) -> QueryBuilder<M, R> {
    select(keyPath1)
      .select(keyPath2)
      .select(keyPath3)
      .select(keyPath4)
      .select(keyPath5)
      .select(keyPath6)
  }

  func select<V1: Expression, V2: Expression, V3: Expression, V4: Expression, V5: Expression, V6: Expression, V7: Expression>(
    _ keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>,
    _ keyPath5: KeyPath<Object<M>, V5>,
    _ keyPath6: KeyPath<Object<M>, V6>,
    _ keyPath7: KeyPath<Object<M>, V7>
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
