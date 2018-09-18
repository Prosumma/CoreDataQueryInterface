//
//  Alias.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/15/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/// A type used to alias an expression's type and or name, or to provide one or both if missing.
public struct Alias: Expression, Named, Typed {
    
    public let cdqiExpression: NSExpression
    public let cdqiName: String
    public let cdqiAttributeType: NSAttributeType
    
    init(_ expression: Expression, as name: String, type: NSAttributeType) {
        cdqiExpression = expression.cdqiExpression
        cdqiName = name
        cdqiAttributeType = type
    }
    
    init(_ expression: Expression & Named, type: NSAttributeType, as name: String? = nil) {
        self.init(expression, as: name ?? expression.cdqiName, type: type)
    }
    
    init(_ expression: Expression & Typed, as name: String, type: NSAttributeType? = nil) {
        self.init(expression, as: name, type: type ?? expression.cdqiAttributeType)
    }
}

/**
 Provide a `name` and `NSAttributeType` for the given expression.
 */
public func alias(_ expression: Expression, as name: String, type: NSAttributeType) -> Alias {
    return Alias(expression, as: name, type: type)
}

public func alias(_ expression: Expression & Named, type: NSAttributeType, as name: String? = nil) -> Alias {
    return Alias(expression, type: type, as: name)
}

public func alias(_ expression: Expression & Typed, as name: String, type: NSAttributeType? = nil) -> Alias {
    return Alias(expression, as: name, type: type)
}

/**
 Allows a Core Data keypath expression to be used directly.
 
 ```
 Employee.cdqiQuery.select(keypath("department.name", as: "departmentName", type: .stringAttributeType))
 ```
 
 While this capability exists, it should be avoided. Instead, one should say
 
 ```
 Employee.cdqiQuery.select(Employee.e.department.name)
 ```
 
 - parameter keyPath: The Core Data keypath
 - parameter name: The name to use in the result
 - parameter type: The type of the expression
 */
public func keypath(_ keyPath: String, as name: String, type: NSAttributeType) -> Alias {
    return Alias(NSExpression(forKeyPath: keyPath), as: name, type: type)
}

public extension Expression {
    
    /// Specify or override the name and type of an expression
    func cdqiAlias(as name: String, type: NSAttributeType) -> Alias {
        return alias(self, as: name, type: type)
    }
    
}

public extension Expression where Self: Typed {
    
    /// Specify or override the name (and optionally type) of an expression
    func cdqiAlias(as name: String, type: NSAttributeType? = nil) -> Alias {
        return alias(self, as: name, type: type)
    }
    
}

public extension Expression where Self: Named {
    
    /// Specify or override the type (and optionally name) of an expression
    func cdqiAlias(type: NSAttributeType, as name: String? = nil) -> Alias {
        return alias(self, type: type, as: name)
    }
    
}
