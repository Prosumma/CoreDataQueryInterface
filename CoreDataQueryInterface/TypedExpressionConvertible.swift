//
//  TypedExpressionConvertible.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 3/28/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

/**
 Implemented by types that participate in typesafe predicates and produce `NSExpression`.
 */
public protocol TypedExpressionConvertible: CustomExpressionConvertible {
    /**
     The type which makes any two `TypedExpressionConvertible`s type-equivalent.
     
     - remarks: Any two `TypedExpressionConvertible`s having the same `ExpressionValueType` can
     be compared for equality. If that `ExpressionValueType` implements `ComparableExpression`,
     than they can be used in ordered comparisons as well.
     
     To see an example, look at `StringAttribute`. Note especially that both `StringAttribute`
     *and* `String` implement this protocol, and `String` implements `ComparableExpression`.
    */
    associatedtype ExpressionValueType
}

public protocol ComparableExpression { }

extension TypedExpressionConvertible {
    public func equalTo<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.equalTo(lhs: self, rhs: rhs, options: options)
    }
    
    public func equalTo(rhs: Null) -> NSPredicate {
        return PredicateBuilder.equalTo(lhs: self, rhs: rhs)
    }
    
    public func notEqualTo<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.notEqualTo(lhs: self, rhs: rhs, options: options)
    }
    
    public func notEqualTo(rhs: Null) -> NSPredicate {
        return PredicateBuilder.notEqualTo(lhs: self, rhs: rhs)
    }
    
    public func among<RE: TypedExpressionConvertible, R: SequenceType where Self.ExpressionValueType == RE.ExpressionValueType, R.Generator.Element == RE>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.among(lhs: self, rhs: rhs, options: options)
    }
}

extension TypedExpressionConvertible where ExpressionValueType: ComparableExpression {
    public func greaterThan<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.greaterThan(lhs: self, rhs: rhs, options: options)
    }
    
    public func greaterThanOrEqualTo<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.greaterThanOrEqualTo(lhs: self, rhs: rhs, options: options)
    }
    
    public func lessThan<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.lessThan(lhs: self, rhs: rhs, options: options)
    }

    public func lessThanOrEqualTo<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.lessThanOrEqualTo(lhs: self, rhs: rhs, options: options)
    }
    
    public func between<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(start: R, and end: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.between(lhs: self, start: start, and: end, options: options)
    }
}

