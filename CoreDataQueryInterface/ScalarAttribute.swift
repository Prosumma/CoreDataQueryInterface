//
//  ScalarAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol ScalarAttribute: Inconstant, Typed, TypeComparable, KeyPathExpression {
    init(key: String, parent: EntityAttribute)
}
