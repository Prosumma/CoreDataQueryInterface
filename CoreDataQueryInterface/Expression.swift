//
//  Expression.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public enum Expression {
    case Property(NSPropertyDescription)
    case Attribute(String)
    // First is the function name, then the attribute name/keypath, then the type
    case Function(String, String, NSAttributeType?)
}

