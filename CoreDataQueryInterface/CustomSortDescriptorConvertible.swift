//
//  CustomSortDescriptorConvertible.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

/**
`CustomSortDescriptorConvertible` represents a type that can be converted to a sort descriptor.

- note: `NSSortDescriptor` itself implements this protocol. It ignores the
`ascending` parameter of `toSortDescriptor`. So, `order(descending: NSSortDescriptor(key: "foo", ascending: true))`
sorts ascending, *not* descending. For this reason, it's best to use
`NSSortDescriptor` with the overloads of `order()` that do not contain the
`descending` keyword argument.
*/
public protocol CustomSortDescriptorConvertible {
    /** Convert the underlying type to `NSSortDescriptor` */
    func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor
}

extension NSSortDescriptor: CustomSortDescriptorConvertible {
    public func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return self
    }
}

extension String: CustomSortDescriptorConvertible {
    public func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return NSSortDescriptor(key: self, ascending: ascending)
    }
}

extension Attribute: CustomSortDescriptorConvertible {
    public func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return NSSortDescriptor(key: String(self), ascending: ascending)    
    }
}