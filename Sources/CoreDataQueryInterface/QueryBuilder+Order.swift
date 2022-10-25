//
//  QueryBuilder+Order.swift
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
  
  func order<V: E>(_ direction: SortDirection = .ascending, by keyPath: KeyPath<O, V>) -> QueryBuilder<M, R> {
    order(by: .init(objectKeyPath: keyPath, ascending: direction.isAscending))
  }

  func order<V1: E, V2: E>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>
  ) -> QueryBuilder<M, R> {
    let sortDescriptors = [
      NSSortDescriptor(objectKeyPath: keyPath1, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath2, ascending: direction.isAscending),
    ]
    return order(by: sortDescriptors)
  }

  func order<V1: E, V2: E, V3: E>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>
  ) -> QueryBuilder<M, R> {
    let sortDescriptors = [
      NSSortDescriptor(objectKeyPath: keyPath1, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath2, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath3, ascending: direction.isAscending),
    ]
    return order(by: sortDescriptors)
  }

  func order<V1: E, V2: E, V3: E, V4: E>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>
  ) -> QueryBuilder<M, R> {
    let sortDescriptors = [
      NSSortDescriptor(objectKeyPath: keyPath1, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath2, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath3, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath4, ascending: direction.isAscending),
    ]
    return order(by: sortDescriptors)
  }

  func order<V1: E, V2: E, V3: E, V4: E, V5: E>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>,
    _ keyPath5: KeyPath<O, V5>
  ) -> QueryBuilder<M, R> {
    let sortDescriptors = [
      NSSortDescriptor(objectKeyPath: keyPath1, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath2, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath3, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath4, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath5, ascending: direction.isAscending),
    ]
    return order(by: sortDescriptors)
  }

  func order<V1: E, V2: E, V3: E, V4: E, V5: E, V6: E>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>,
    _ keyPath5: KeyPath<O, V5>,
    _ keyPath6: KeyPath<O, V6>
  ) -> QueryBuilder<M, R> {
    let sortDescriptors = [
      NSSortDescriptor(objectKeyPath: keyPath1, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath2, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath3, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath4, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath5, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath6, ascending: direction.isAscending),
    ]
    return order(by: sortDescriptors)
  }

  func order<V1: E, V2: E, V3: E, V4: E, V5: E, V6: E, V7: E>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<O, V1>,
    _ keyPath2: KeyPath<O, V2>,
    _ keyPath3: KeyPath<O, V3>,
    _ keyPath4: KeyPath<O, V4>,
    _ keyPath5: KeyPath<O, V5>,
    _ keyPath6: KeyPath<O, V6>,
    _ keyPath7: KeyPath<O, V7>
  ) -> QueryBuilder<M, R> {
    let sortDescriptors = [
      NSSortDescriptor(objectKeyPath: keyPath1, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath2, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath3, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath4, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath5, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath6, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath7, ascending: direction.isAscending),
    ]
    return order(by: sortDescriptors)
  }
}
