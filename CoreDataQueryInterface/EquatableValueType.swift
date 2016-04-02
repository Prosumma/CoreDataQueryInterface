//
//  EquatableValueType.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 4/1/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

extension TypedExpressionConvertible {
    
    public func equalTo(rhs: ValueType?, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs?.expressionValue, type: .EqualToPredicateOperatorType, options: options)
    }
    
    public func notEqualTo(rhs: ValueType?, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs?.expressionValue, type: .NotEqualToPredicateOperatorType, options: options)
    }
    
    public func among(rhs: [ValueType], options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        let values = rhs.map({ $0.expressionValue })
        
        return among(values, options: options)
    }
}

extension TypedExpressionConvertible where ValueType: NSManagedObject {
    
    public func among(rhs: [NSManagedObjectID], options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return among(rhs, options: options)
    }
}

extension TypedExpressionConvertible where ValueType: CollectionType {
    
    public func equalTo(rhs: ValueType?, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs?.expressionValue, type: .EqualToPredicateOperatorType, options: options)
    }
    
    public func notEqualTo(rhs: ValueType?, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        return compare(rhs?.expressionValue, type: .NotEqualToPredicateOperatorType, options: options)
    }
}

