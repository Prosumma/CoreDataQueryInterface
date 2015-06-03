//
//  Attribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/3/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol AttributeType : Printable {
    init()
    init(_ name: String, parent: AttributeType?)
}

public class Attribute : AttributeType {
    
    private let _name: String?
    private let _parent: AttributeType?
    
    public required init() {
        _name = nil
        _parent = nil
    }
    
    public required init(_ name: String, parent: AttributeType? = nil) {
        _name = name
        _parent = parent
    }
    
    public var description: String {
        if let parent = _parent {
            return (parent.description == "" ? "" : ".") + _name!
        } else {
            return _name ?? ""
        }
    }
    
}

public func &&(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate.andPredicateWithSubpredicates([lhs, rhs])
}

public func ||(lhs: NSPredicate, rhs: NSPredicate) -> NSPredicate {
    return NSCompoundPredicate.orPredicateWithSubpredicates([lhs, rhs])
}

public func ==<A: AttributeType>(lhs: A, rhs: Int) -> NSPredicate {
    return NSPredicate(format: "%K == %d", lhs.description, rhs)
}

public func <<A: AttributeType>(lhs: A, rhs: Int) -> NSPredicate {
    return NSPredicate(format: "%K < %d", lhs.description, rhs)
}

public func ==<A: AttributeType>(lhs: A, rhs: NSObject) -> NSPredicate {
    return NSPredicate(format: "%K == %@", lhs.description, rhs)
}

public func ==<A: AttributeType>(lhs: A, rhs: String) -> NSPredicate {
    return NSPredicate(format: "%K == %@", lhs.description, rhs)
}

