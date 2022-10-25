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
  
  func group<V: Expression>(by keyPath: KeyPath<Object<M>, V>) -> QueryBuilder<M, R> {
    let object = Object<M>()
    let expression = object[keyPath: keyPath]
    return group(by: "\(expression.pqiExpression)")
  }
  
  private func group(by properties: [FetchedProperty]) -> QueryBuilder<M, R> {
    var query = self
    query.propertiesToGroupBy.append(contentsOf: properties)
    return query
  }
}
