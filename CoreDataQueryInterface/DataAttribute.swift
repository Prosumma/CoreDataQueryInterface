//
//  DataAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension NSData: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSData
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

public class DataAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = NSData
    public required init(_ name: String, parent: Attribute? = nil, type: NSAttributeType? = nil) {
        super.init(name, parent: parent, type: .BinaryDataAttributeType)
    }
    public required init() {
        super.init()
    }
}

