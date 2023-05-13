//
//  Attributed.swift
//  CoreDataQueryInterface
//
//  Created by Greg Higley on 2023-05-13.
//

import CoreData
import PredicateQI

public protocol Attributed {
  static var attributeType: NSAttributeDescription.AttributeType { get }
}

extension TypedExpression: Attributed where T: Attributed {
  public static var attributeType: NSAttributeDescription.AttributeType {
    T.attributeType
  }
}

extension String: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .string
}

extension Int16: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .integer16
}

extension Int32: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .integer32
}

extension Int64: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .integer64
}
