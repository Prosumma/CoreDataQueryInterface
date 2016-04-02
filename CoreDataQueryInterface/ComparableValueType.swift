//
//  ComparableValueType.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 4/1/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

extension TypedExpressionConvertible where ValueType: ComparableValueType {
    
    public func greaterThan(rhs: ValueType?, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs?.expressionValue, type: .GreaterThanPredicateOperatorType, options: options)
    }
    
    public func greaterThanOrEqualTo(rhs: ValueType?, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs?.expressionValue, type: .GreaterThanOrEqualToPredicateOperatorType, options: options)
    }
    
    public func lessThan(rhs: ValueType?, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs?.expressionValue, type: .LessThanPredicateOperatorType, options: options)
    }
    
    public func lessThanOrEqualTo(rhs: ValueType?, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs?.expressionValue, type: .LessThanOrEqualToPredicateOperatorType, options: options)
    }
    
    public func between(start: ValueType, and end: ValueType, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        let startExpression: NSExpression
        if let start = start as? CustomExpressionConvertible {
            startExpression = start.expression
        } else {
            startExpression = NSExpression(forConstantValue: (start as! AnyObject))
        }
        let endExpression: NSExpression
        if let end = end as? CustomExpressionConvertible {
            endExpression = end.expression
        } else {
            endExpression = NSExpression(forConstantValue: (end as! AnyObject))
        }
        let rhsExpression = NSExpression(forAggregate: [startExpression, endExpression])
        return compare(rhsExpression, type: .BetweenPredicateOperatorType, options: options)
    }
}