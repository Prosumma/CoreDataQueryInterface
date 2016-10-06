//
//  Extensions.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension NSManagedObjectContext {
    public func from<M: NSManagedObject>(_ entity: M.Type = M.self) -> Query<M, M> where M: Entity {
        return Query<M, M>().context(managedObjectContext: self)
    }
    
    public func cdqiNewEntity<M: NSManagedObject>(_ entity: M.Type = M.self) -> M {
        return M(entity: M.entity(), insertInto: self)
    }
}

extension ExpressionConvertible {
    public func cdqiAverage(alias name: String? = nil, type: NSAttributeType? = nil) -> PropertyConvertible {
        return average(self, alias: name, type: type)
    }
    
    public func cdqiCount(alias name: String? = nil) -> PropertyConvertible {
        return count(self, alias: name, type: .integer32AttributeType)
    }
    
    public func cdqiMin(alias name: String? = nil, type: NSAttributeType? = nil) -> PropertyConvertible {
        return min(self, alias: name, type: type)
    }
    
    public func cdqiMax(alias name: String? = nil, type: NSAttributeType? = nil) -> PropertyConvertible {
        return max(self, alias: name, type: type)
    }
    
    public func cdqiSum(alias name: String? = nil, type: NSAttributeType? = nil) -> PropertyConvertible {
        return sum(self, alias: name, type: type)
    }
    
    public func cdqiCompare(_ op: NSComparisonPredicate.Operator, _ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, op, rhs, options: options)
    }
    
    public func cdqiCompare(_ op: NSComparisonPredicate.Operator, _ rhs: Null, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, op, rhs, options: options)
    }
    
    public func cdqiEqualTo(_ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .equalTo, rhs, options: options)
    }
    
    public func cdqiEqualTo(_ rhs: Null, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .equalTo, rhs, options: options)
    }
    
    public func cdqiNotEqualTo(_ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .notEqualTo, rhs, options: options)
    }
    
    public func cdqiNotEqualTo(_ rhs: Null, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .notEqualTo, rhs, options: options)
    }
    
    public func cdqiLessThan(_ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .lessThan, rhs, options: options)
    }
    
    public func cdqiLessThanOrEqualTo(_ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .lessThanOrEqualTo, rhs, options: options)
    }
    
    public func cdqiGreaterThan(_ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .greaterThan, rhs, options: options)
    }
    
    public func cdqiGreaterThanOrEqualTo(_ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .greaterThanOrEqualTo, rhs, options: options)
    }
    
    public func cdqiAmong<R: Sequence>(_ rhs: R, options: NSComparisonPredicate.Options = []) -> NSPredicate where R.Iterator.Element: ExpressionConvertible {
        let re = NSExpression(forAggregate: rhs.map{ $0.cdqiExpression })
        return compare(self, .in, re, options: options)
    }
    
    public func cdqiBetween(_ lhs: ExpressionConvertible, and rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return between(self, lhs, and: rhs, options: options)
    }

    public func cdqiContains(_ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .contains, rhs, options: options)
    }
    
    public func cdqiLike(_ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .like, rhs, options: options)
    }
    
    public func cdqiBeginsWith(_ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .beginsWith, rhs, options: options)
    }
    
    public func cdqiEndsWith(_ rhs: ExpressionConvertible, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return compare(self, .endsWith, rhs, options: options)
    }
    
    public func cdqiMatches(_ rhs: String, options: NSComparisonPredicate.Options = []) -> NSPredicate {
        return matches(self, rhs, options: options)
    }
    
    public func cdqiAlias(name: String, type: NSAttributeType) -> PropertyConvertible {
        let property = NSExpressionDescription()
        property.expression = cdqiExpression
        property.name = name
        property.expressionResultType = type
        return property
    }
    
    public func cdqiAlias(name: String) -> PropertyConvertible {
        var type: NSAttributeType = .undefinedAttributeType
        if let typed = self as? Typed {
            type = typed.cdqiType
        }
        return alias(self, name: name, type: type)
    }
}

extension KeyPathExpressionConvertible {
    public func cdqiAlias(type: NSAttributeType) -> PropertyConvertible {
        return alias(self, name: cdqiName, type: type)
    }
}

extension NSPredicate {
    public func cdqiAll() -> NSPredicate {
        return all(self)
    }
    public func cdqiAny() -> NSPredicate {
        return any(self)
    }
    public func cdqiSome() -> NSPredicate {
        return some(self)
    }
    public func cdqiNot() -> NSPredicate {
        return !self
    }
}
