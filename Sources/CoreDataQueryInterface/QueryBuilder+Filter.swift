//
//  QueryBuilder+Filter.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-22.
//

import Foundation
import PredicateQI

public extension QueryBuilder {
  func filter(_ predicate: NSPredicate) -> QueryBuilder<M, R> {
    var query = self
    query.predicates.append(predicate)
    return query
  }
  
  func filter(_ format: String, _ args: Any...) -> QueryBuilder<M, R> {
    filter(NSPredicate(format: format, argumentArray: args))
  }
  
  func filter(_ isIncluded: (Object<M>) -> PredicateBuilder) -> QueryBuilder<M, R> {
    filter(pred(isIncluded(.init())))
  }
}
