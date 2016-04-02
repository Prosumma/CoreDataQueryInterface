//
//  EntityAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/2/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

public class EntityAttribute: Attribute, Aggregable, TypedExpressionConvertible {
    public typealias ExpressionValueType = Entity
}