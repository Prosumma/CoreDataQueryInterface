//
//  Alias.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/15/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct Alias: Expression, Named, Typed {
    
    public let cdqiExpression: NSExpression
    public let cdqiName: String
    public let cdqiType: NSAttributeType
    
    init(_ expression: Expression, name: String, type: NSAttributeType) {
        cdqiExpression = expression.cdqiExpression
        cdqiName = name
        cdqiType = type
    }
    
}

public func alias(_ expression: Expression, name: String, type: NSAttributeType) -> Alias {
    return Alias(expression, name: name, type: type)
}

public func alias(_ expression: Expression & Named, type: NSAttributeType, name: String? = nil) -> Alias {
    return Alias(expression, name: name ?? expression.cdqiName, type: type)
}

public func alias(_ expression: Expression & Typed, name: String, type: NSAttributeType? = nil) -> Alias {
    return Alias(expression, name: name, type: type ?? expression.cdqiType)
}

public func keypath(_ keyPath: String, name: String, type: NSAttributeType) -> Alias {
    return Alias(NSExpression(forKeyPath: keyPath), name: name, type: type)
}

public extension Expression {
    
    func cdqiAlias(name: String, type: NSAttributeType) -> Alias {
        return alias(self, name: name, type: type)
    }
    
}

public extension Expression where Self: Typed {
    
    func cdqiAlias(name: String, type: NSAttributeType? = nil) -> Alias {
        return alias(self, name: name, type: type)
    }
    
}

public extension Expression where Self: Named {
    
    func cdqiAlias(type: NSAttributeType, name: String? = nil) -> Alias {
        return alias(self, type: type, name: name)
    }
    
}
