//
//  Expression.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 A protocol that wraps a type that can be converted into a Core Data
 `NSExpression`. This protocol is one of the fundamental building blocks
 of CDQI.
 */
public protocol Expression {
    /// The `NSExpression` produced by the receiver.
    var cdqiExpression: NSExpression { get }
}
