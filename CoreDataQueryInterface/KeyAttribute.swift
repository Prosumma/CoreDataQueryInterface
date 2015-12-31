//
//  KeyAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 12/28/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 Use this subclass of `Attribute` for simple keys.
 */
class KeyAttribute: Attribute, Aggregable {
    typealias AggregateType = KeyAttribute
}
