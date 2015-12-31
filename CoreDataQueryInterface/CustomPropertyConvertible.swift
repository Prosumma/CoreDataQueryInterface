//
//  CustomPropertyConvertible.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 12/28/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

public protocol CustomPropertyConvertible {
    var property: AnyObject { get }
}

extension String: CustomPropertyConvertible {
    public var property: AnyObject {
        return self
    }
}

extension NSPropertyDescription: CustomPropertyConvertible {
    public var property: AnyObject {
        return self
    }
}

