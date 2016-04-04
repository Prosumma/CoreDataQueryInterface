//
//  BooleanAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension Bool: TypedExpressionConvertible {
    public typealias ExpressionValueType = Bool
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

public class BooleanAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = Bool
    public required init(_ name: String, parent: Attribute? = nil, type: NSAttributeType? = nil) {
        super.init(name, parent: parent, type: .BooleanAttributeType)
    }
    public required init() {
        super.init()
    }
}

