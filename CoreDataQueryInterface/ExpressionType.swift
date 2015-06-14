//
//  ExpressionType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol ExpressionType {
    var expression: NSExpression { get }
    func propertyDescription(entity: NSEntityDescription) -> NSPropertyDescription
}

extension String : ExpressionType {
    public var expression: NSExpression {
        return Expression.KeyPath(self, nil, nil).expression
    }
    public func propertyDescription(entity: NSEntityDescription) -> NSPropertyDescription {
        return Expression.KeyPath(self, nil, nil).propertyDescription(entity)
    }
}

extension NSPropertyDescription : ExpressionType {
    public var expression: NSExpression {
        return Expression.Property(self).expression
    }
    public func propertyDescription(entity: NSEntityDescription) -> NSPropertyDescription {
        return self
    }
}

extension AttributeType {
    public var expression: NSExpression {
        return Expression.KeyPath(String(self), nil, nil).expression
    }
    public func propertyDescription(entity: NSEntityDescription) -> NSPropertyDescription {
        return Expression.KeyPath(String(self), nil, nil).propertyDescription(entity)
    }
}