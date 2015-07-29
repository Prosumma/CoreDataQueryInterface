//
//  OrderType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

/**
`OrderType` represents a type that can be converted to a sort descriptor.

- note: `NSSortDescriptor` itself implements this protocol. It ignores the
`ascending` parameter of `toSortDescriptor`. So, `order(descending: NSSortDescriptor(key: "foo", ascending: true))`
sorts ascending, *not* descending. For this reason, it's best to use
`NSSortDescriptor` with the overloads of `order()` that do not contain the
`descending` keyword argument.
*/
public protocol OrderType {
    /** Convert the underlying type to `NSSortDescriptor` */
    func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor
}

extension NSSortDescriptor : OrderType {
    public func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return self
    }
}

extension String : OrderType {
    public func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return NSSortDescriptor(key: self, ascending: ascending)
    }
}

extension AttributeType {
    public func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return NSSortDescriptor(key: String(self), ascending: ascending)
    }
}
