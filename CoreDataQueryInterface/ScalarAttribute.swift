//
//  ScalarAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/// A convenience protocol for scalar (as opposed to entity) attributes such as `StringAttribute`, `DoubleAttribute`, etc.
public protocol ScalarAttribute: Inconstant, Typed, TypeComparable, KeyPathExpression {
    init(key: String, parent: EntityAttribute)
}
