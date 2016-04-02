//
//  Aggregable.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 12/28/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol Aggregable: Countable {
    associatedtype AggregateType: Attribute = Self
    func subquery(variable: String, predicate: AggregateType -> NSPredicate) -> Countable
    func subquery(predicate: AggregateType -> NSPredicate) -> Countable
    var average: AggregateType { get }
    var sum: AggregateType { get }
    var max: AggregateType { get }
    var min: AggregateType { get }
}

