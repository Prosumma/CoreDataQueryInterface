//
//  CustomExpressionConvertible.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 12/28/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

public protocol CustomExpressionConvertible {
    var expression: NSExpression { get }
}

extension CustomExpressionConvertible {
    public func compare(rhs: AnyObject?, type: NSPredicateOperatorType, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        let rightExpression: NSExpression
        if let rhs = rhs as? CustomExpressionConvertible {
            rightExpression = rhs.expression
        } else {
            rightExpression = NSExpression(forConstantValue: rhs)
        }
        return NSComparisonPredicate(leftExpression: expression, rightExpression: rightExpression, modifier: .DirectPredicateModifier, type: type, options: options)
    }
    
    public func among(rhs: [AnyObject], options: NSComparisonPredicateOptions = []) -> NSPredicate {
        
        var expressions = [AnyObject]()
        for elem in rhs {
            let e: NSExpression
            if let c = elem as? CustomExpressionConvertible {
                e = c.expression
            } else {
                e = NSExpression(forConstantValue: elem)
            }
            expressions.append(e)
        }
        
        return compare(NSExpression(forAggregate: expressions), type: .InPredicateOperatorType, options: options)
    }
}

extension NSExpression: CustomExpressionConvertible {
    public var expression: NSExpression {
        return self
    }
}
