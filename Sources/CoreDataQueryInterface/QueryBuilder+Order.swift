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
  
  func order<V: Expression>(_ direction: SortDirection = .ascending, by keyPath: KeyPath<Object<M>, V>) -> QueryBuilder<M, R> {
    order(by: .init(objectKeyPath: keyPath, ascending: direction.isAscending))
  }

  func order<V1: Expression, V2: Expression>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>
  ) -> QueryBuilder<M, R> {
    let sortDescriptors = [
      NSSortDescriptor(objectKeyPath: keyPath1, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath2, ascending: direction.isAscending),
    ]
    return order(by: sortDescriptors)
  }

  func order<V1: Expression, V2: Expression, V3: Expression>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>
  ) -> QueryBuilder<M, R> {
    let sortDescriptors = [
      NSSortDescriptor(objectKeyPath: keyPath1, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath2, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath3, ascending: direction.isAscending),
    ]
    return order(by: sortDescriptors)
  }

  func order<V1: Expression, V2: Expression, V3: Expression, V4: Expression>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>
  ) -> QueryBuilder<M, R> {
    let sortDescriptors = [
      NSSortDescriptor(objectKeyPath: keyPath1, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath2, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath3, ascending: direction.isAscending),
      NSSortDescriptor(objectKeyPath: keyPath4, ascending: direction.isAscending),
    ]
    return order(by: sortDescriptors)
  }

  func order<V1: Expression, V2: Expression, V3: Expression, V4: Expression, V5: Expression>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>,
    _ keyPath5: KeyPath<Object<M>, V5>
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

  func order<V1: Expression, V2: Expression, V3: Expression, V4: Expression, V5: Expression, V6: Expression>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>,
    _ keyPath5: KeyPath<Object<M>, V5>,
    _ keyPath6: KeyPath<Object<M>, V6>
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

  func order<V1: Expression, V2: Expression, V3: Expression, V4: Expression, V5: Expression, V6: Expression, V7: Expression>(
    _ direction: SortDirection = .ascending,
    by keyPath1: KeyPath<Object<M>, V1>,
    _ keyPath2: KeyPath<Object<M>, V2>,
    _ keyPath3: KeyPath<Object<M>, V3>,
    _ keyPath4: KeyPath<Object<M>, V4>,
    _ keyPath5: KeyPath<Object<M>, V5>,
    _ keyPath6: KeyPath<Object<M>, V6>,
    _ keyPath7: KeyPath<Object<M>, V7>
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
