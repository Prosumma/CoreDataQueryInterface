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
public class KeyAttribute: Attribute, Aggregable {
    public typealias AggregateType = KeyAttribute
}
