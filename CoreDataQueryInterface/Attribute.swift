//
//  Attribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/3/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol AttributeType : CustomStringConvertible {
    init(_ name: String?, parent: AttributeType?)
}

public class Attribute : AttributeType {
    
    private let _name: String?
    private let _parent: AttributeType?

    public required init(_ name: String? = nil, parent: AttributeType? = nil) {
        _name = name
        _parent = parent
    }
    
    public var description: String {
        if let parent = _parent {
            return (String(parent) == "" ? "" : (String(parent) + ".")) + _name!
        } else {
            return _name ?? ""
        }
    }
    
}
