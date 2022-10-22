//
//  QueryBuilder+Sort.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-22.
//

import Foundation
import PredicateQI

public extension QueryBuilder {
  enum SortDirection {
    case ascending, descending
    
    var isAscending: Bool {
      self == .ascending
    }
  }
  
  func order(by sortDescriptors: [NSSortDescriptor]) -> QueryBuilder<M, R> {
    var query = self
    query.sortDescriptors.append(contentsOf: sortDescriptors)
    return query
  }
  
  func order(by sortDescriptors: NSSortDescriptor...) -> QueryBuilder<M, R> {
    order(by: sortDescriptors)
  }
  
  func order<V>(_ direction: SortDirection = .ascending, by keyPath: KeyPath<M, V>) -> QueryBuilder<M, R> {
    let sortDescriptor = NSSortDescriptor(keyPath: keyPath, ascending: direction.isAscending)
    var query = self
    query.sortDescriptors.append(sortDescriptor)
    return query
  }
  
  func order<V1, V2>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<M, V1>,
    _ keyPath2: KeyPath<M, V2>
  ) -> QueryBuilder<M, R> {
    order(direction, by: keyPath1)
      .order(direction, by: keyPath2)
  }
  
  func order<V1, V2, V3>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<M, V1>,
    _ keyPath2: KeyPath<M, V2>,
    _ keyPath3: KeyPath<M, V3>
  ) -> QueryBuilder<M, R> {
    order(direction, by: keyPath1)
      .order(direction, by: keyPath2)
      .order(direction, by: keyPath3)
  }
  
  func order<V1, V2, V3, V4>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<M, V1>,
    _ keyPath2: KeyPath<M, V2>,
    _ keyPath3: KeyPath<M, V3>,
    _ keyPath4: KeyPath<M, V4>
  ) -> QueryBuilder<M, R> {
    order(direction, by: keyPath1)
      .order(direction, by: keyPath2)
      .order(direction, by: keyPath3)
      .order(direction, by: keyPath4)
  }
  
  func order<V1, V2, V3, V4, V5>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<M, V1>,
    _ keyPath2: KeyPath<M, V2>,
    _ keyPath3: KeyPath<M, V3>,
    _ keyPath4: KeyPath<M, V4>,
    _ keyPath5: KeyPath<M, V5>
  ) -> QueryBuilder<M, R> {
    order(direction, by: keyPath1)
      .order(direction, by: keyPath2)
      .order(direction, by: keyPath3)
      .order(direction, by: keyPath4)
      .order(direction, by: keyPath5)
  }
}
