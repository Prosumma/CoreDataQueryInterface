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
    name: String? = nil,
    type: NSAttributeDescription.AttributeType? = nil
  ) {
    self.init()
    let expression = Object<M>()[keyPath: keyPath].pqiExpression
    self.expression = expression
    if let name = name {
      self.name = name
    } else if expression.expressionType == .keyPath {
      if let name = expression.keyPath.split(separator: "\\.").last {
        self.name = String(name)
      }
    }
    if let type = type {
      self.resultType = type
    } else if let a = V.self as? Attributed.Type {
      self.resultType = a.attributeType
    }
  }
}
