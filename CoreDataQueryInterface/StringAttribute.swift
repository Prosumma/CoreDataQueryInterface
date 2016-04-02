//
//  StringAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 4/1/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

extension String: ComparableValueType {
    
    public var expressionValue: AnyObject {
        
        return self as NSString
    }
}

public class StringAttribute: KeyAttribute, TypedExpressionConvertible {
    
    public typealias ValueType = String
}

extension TypedExpressionConvertible where ValueType == String {
    
    public func beginsWith(rhs: String, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs, type: .BeginsWithPredicateOperatorType, options: options)
    }
    
    public func contains(rhs: String, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs, type: .ContainsPredicateOperatorType, options: options)
    }
    
    public func endsWith(rhs: String, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs, type: .EndsWithPredicateOperatorType, options: options)
    }
    
    public func like(rhs: String, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs, type: .LikePredicateOperatorType, options: options)
    }
    
    public func matches(rhs: String, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs, type: .MatchesPredicateOperatorType, options: options)
    }
}

