/*
The MIT License (MIT)

Copyright (c) 2015 Gregory Higley (Prosumma)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import Foundation

/**
 Helper class to build predicates.
 
 Use this class to bypass CDQI's type safety in filter expressions, if needed.
 Any type which implements `CustomExpressionConvertible` or its subclass
 `TypedExpressionConvertible` can be used here. Types such as `Int`, `String`,
 `NSNumber` and so on can be used directly.
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
    
    public static func among<R: SequenceType where R.Generator.Element: CustomExpressionConvertible>(lhs lhs: CustomExpressionConvertible, rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
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
