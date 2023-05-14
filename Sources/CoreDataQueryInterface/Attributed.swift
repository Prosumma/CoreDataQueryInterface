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

extension Bool: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .boolean
}

extension Data: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .binaryData
}

extension Date: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .date
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

extension Decimal: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .decimal
}

extension Double: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .double
}

extension Float: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .float
}

extension NSManagedObjectID: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .objectID
}

extension UUID: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .uuid
}

extension URL: Attributed {
  public static let attributeType: NSAttributeDescription.AttributeType = .uri
}
