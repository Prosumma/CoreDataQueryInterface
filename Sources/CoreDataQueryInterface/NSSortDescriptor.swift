//
//  NSSortDescriptor.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-25.
//

import Foundation
import PredicateQI

public extension NSSortDescriptor {
  convenience init<M: NSObject, V: Expression>(objectKeyPath: KeyPath<Object<M>, V>, ascending: Bool) {
    let expression = Object<M>()[keyPath: objectKeyPath].pqiExpression
    self.init(key: expression.keyPath, ascending: ascending)
  }
}
