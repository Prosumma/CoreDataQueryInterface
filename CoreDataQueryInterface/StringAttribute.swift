//
//  StringAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 4/1/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public class StringAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = String
    public required init(_ name: String, parent: Attribute? = nil, type: NSAttributeType? = nil) {
        super.init(name, parent: parent, type: .StringAttributeType)
    }
    public required init() {
        super.init()
    }
}

extension String: TypedExpressionConvertible, ComparableExpression {
    public typealias ExpressionValueType = String
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

extension TypedExpressionConvertible where ExpressionValueType == String {
    public func beginsWith<R: TypedExpressionConvertible where ExpressionValueType == String>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.beginsWith(lhs: self, rhs: rhs, options: options)
    }

    public func contains<R: TypedExpressionConvertible where ExpressionValueType == String>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.contains(lhs: self, rhs: rhs, options: options)
    }

    public func endsWith<R: TypedExpressionConvertible where ExpressionValueType == String>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.endsWith(lhs: self, rhs: rhs, options: options)
    }

    public func like<R: TypedExpressionConvertible where ExpressionValueType == String>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.like(lhs: self, rhs: rhs, options: options)
    }

    public func matches<R: TypedExpressionConvertible where ExpressionValueType == String>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.matches(lhs: self, rhs: rhs, options: options)
    }
}
