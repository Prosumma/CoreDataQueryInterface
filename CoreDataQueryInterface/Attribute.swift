//
//  Attribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/3/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation

/**
The default implementation of `AttributeType`.
*/
public class Attribute : AttributeType {
    
    private let _name: String?
    private let _parent: AttributeType?

    public required init(_ name: String? = nil, parent: AttributeType? = nil) {
        if let _ = parent { assert(name != nil) }
        if let name = name { assert(!name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).isEmpty) }
        _name = name
        _parent = parent
    }
    
    public var description: String {
        if let parent = _parent {
            let parentName = String(parent)
            let prefix = parentName.isEmpty ? "" : (parentName + ".")
            return prefix + _name!
        } else {
            return _name ?? ""
        }
    }
    
}
