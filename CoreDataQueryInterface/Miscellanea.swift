//
//  Subquery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public func alias(_ expression: ExpressionConvertible, name: String, type: NSAttributeType) -> PropertyConvertible {
    let property = NSExpressionDescription()
    property.expression = expression.cdqiExpression
    property.name = name
    property.expressionResultType = type
    return property
}

public func alias(_ expression: ExpressionConvertible, name: String) -> PropertyConvertible {
    var type: NSAttributeType = .undefinedAttributeType
    if let typed = expression as? Typed {
        type = typed.cdqiType
    }
    return alias(expression, name: name, type: type)
}

public func alias(_ expression: KeyPathExpressionConvertible, type: NSAttributeType) -> PropertyConvertible {
    return alias(expression, name: expression.cdqiName, type: type)
}

public func subquery<E: EntityAttribute>(_ items: E, _ query: (E) -> NSPredicate) -> ExpressionConvertible {
    let uuid = NSUUID().uuidString
    let index = uuid.index(uuid.startIndex, offsetBy: 6)
    let randomString = uuid.substring(to: index)
    let variable = "v\(randomString)"
    return NSExpression(forSubquery: items.cdqiExpression, usingIteratorVariable: variable, predicate: query(E(variable: variable)))
}

public func subqueryCount<E: EntityAttribute>(_ items: E, _ query: (E) -> NSPredicate) -> FunctionExpression {
    return count(subquery(items, query))
}
