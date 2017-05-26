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
        if #available(iOS 10, macOS 10.12, tvOS 10, watchOS 3, *) {
            return M(entity: M.entity(), insertInto: self)
        } else {
            let managedObjectModel = persistentStoreCoordinator!.managedObjectModel
            return M(entity: M.cdqiEntity(managedObjectModel: managedObjectModel), insertInto: self)
        }
    }
}

extension ExpressionConvertible {
    
    public func cdqiAverage(type: NSAttributeType? = nil) -> FunctionExpression {
        return average(self, type: type)
    }
    
    public func cdqiAverage(alias name: String, type: NSAttributeType? = nil) -> PropertyConvertible {
        return average(self, alias: name, type: type)
    }
    
    public func cdqiCount(type: NSAttributeType? = nil) -> FunctionExpression {
        return count(self, type: type)
    }
    
    public func cdqiCount(alias name: String) -> PropertyConvertible {
        return count(self, alias: name, type: .integer32AttributeType)
    }
    
    public func cdqiMin(type: NSAttributeType? = nil) -> FunctionExpression {
        return min(self, type: type)
    }
    
    public func cdqiMin(alias name: String, type: NSAttributeType? = nil) -> PropertyConvertible {
        return min(self, alias: name, type: type)
    }
    
    public func cdqiMax(type: NSAttributeType? = nil) -> FunctionExpression {
        return max(self, type: type)
    }
    
    public func cdqiMax(alias name: String, type: NSAttributeType? = nil) -> PropertyConvertible {
        return max(self, alias: name, type: type)
    }
    
    public func cdqiSum(type: NSAttributeType? = nil) -> FunctionExpression {
        return sum(self, type: type)
    }
    
    public func cdqiSum(alias name: String, type: NSAttributeType? = nil) -> PropertyConvertible {
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

/**
 Returns the name of the entity corresponding to the current class.
 - parameter aClass: The class for which to retrieve the entity
 - parameter managedObjectModel: The managed object model in which to look for the entity.
 - returns: The name of the entity.
 */
public func entityNameForClass(aClass: AnyClass, inManagedObjectModel managedObjectModel: NSManagedObjectModel) -> String? {
    struct Static {
        static var entityCache = [String: String]()
        static let entityCacheQueue = DispatchQueue(label: "com.prosumma.coredataqueryinterface.EntityCacheQueue")
    }
    let className = String(validatingUTF8: class_getName(aClass))!
    var entityName: String?
    Static.entityCacheQueue.sync {
        entityName = Static.entityCache[className]
        if entityName == nil {
            entityName = managedObjectModel.entities.filter{ $0.managedObjectClassName == className }.first?.name
            Static.entityCache[className] = entityName
        }
    }
    return entityName
}

extension NSManagedObject {
    public static func cdqiEntity(managedObjectModel: NSManagedObjectModel) -> NSEntityDescription {
        let entityName = entityNameForClass(aClass: self, inManagedObjectModel: managedObjectModel)!
        return managedObjectModel.entitiesByName[entityName]!
    }
}

