//
//  OrderType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol OrderType {
    func sortDescriptor(ascending ascending: Bool) -> NSSortDescriptor
}

extension NSSortDescriptor : OrderType {
    public func sortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return self
    }
}

extension String : OrderType {
    public func sortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return NSSortDescriptor(key: self, ascending: ascending)
    }
}

extension AttributeType {
    public func sortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return NSSortDescriptor(key: String(self), ascending: ascending)
    }
}
