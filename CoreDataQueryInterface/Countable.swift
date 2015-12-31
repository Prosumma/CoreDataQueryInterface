//
//  Countable.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 12/30/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol Countable {
    var count: NSExpression { get }
}

extension NSExpression: Countable {
    public var count: NSExpression {
        return NSExpression(format: "%@.@count", self)
    }
}