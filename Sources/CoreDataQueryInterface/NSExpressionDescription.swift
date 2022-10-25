//
//  NSExpressionDescription.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 2022-10-25.
//

import CoreData
import PredicateQI

public extension NSExpressionDescription {
  convenience init<M: NSObject, V: Expression>(
    objectKeyPath keyPath: KeyPath<Object<M>, V>,
    name: String,
    type: NSAttributeDescription.AttributeType
  ) {
    self.init()
    self.expression = Object<M>()[keyPath: keyPath].pqiExpression
    self.name = name
    self.resultType = type
  }
}
