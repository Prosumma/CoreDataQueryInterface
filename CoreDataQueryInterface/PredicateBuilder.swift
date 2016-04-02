//
//  PredicateBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 Helper class to build predicates.
 */
public struct PredicateBuilder {
    private init() {}
    
    public static func compare(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, type: NSPredicateOperatorType, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return NSComparisonPredicate(leftExpression: lhs.expression, rightExpression: rhs.expression, modifier: .DirectPredicateModifier, type: type, options: options)
    }
    
    public static func equalTo(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .EqualToPredicateOperatorType, options: options)
    }
    
    public static func notEqualTo(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .NotEqualToPredicateOperatorType, options: options)
    }
    
    public static func greaterThan(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .GreaterThanPredicateOperatorType, options: options)
    }
    
    public static func greaterThanOrEqualTo(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .GreaterThanOrEqualToPredicateOperatorType, options: options)
    }
    
    public static func lessThan(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .LessThanPredicateOperatorType, options: options)
    }
    
    public static func lessThanOrEqualTo(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .LessThanOrEqualToPredicateOperatorType, options: options)
    }
    
    public static func among(lhs lhs: CustomExpressionConvertible, rhs: [CustomExpressionConvertible], options: NSComparisonPredicateOptions = []) -> NSPredicate {
        let expressions = rhs.map { $0.expression }
        return compare(lhs: lhs, rhs: NSExpression(forAggregate: expressions), type: .InPredicateOperatorType, options: options)
    }
    
    public static func between(lhs lhs: CustomExpressionConvertible, start: CustomExpressionConvertible, and end: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        let re = NSExpression(forAggregate: [start.expression, end.expression])
        return compare(lhs: lhs, rhs: re, type: .BetweenPredicateOperatorType, options: options)
    }
    
    public static func beginsWith(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .BeginsWithPredicateOperatorType, options: options)
    }
    
    public static func contains(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .ContainsPredicateOperatorType, options: options)
    }
    
    public static func endsWith(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .EndsWithPredicateOperatorType, options: options)
    }
    
    public static func like(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .LikePredicateOperatorType, options: options)
    }
    
    public static func matches(lhs lhs: CustomExpressionConvertible, rhs: CustomExpressionConvertible, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return compare(lhs: lhs, rhs: rhs, type: .MatchesPredicateOperatorType, options: options)
    }
}