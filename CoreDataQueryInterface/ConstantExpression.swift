//
//  ConstantExpression.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol ConstantExpression: Expression {}

public extension ConstantExpression {
    var cdqiExpression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

