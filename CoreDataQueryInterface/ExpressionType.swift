//
//  ExpressionType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol ExpressionType {
    func propertyDescription(entity: NSEntityDescription) -> NSPropertyDescription
}

extension String : ExpressionType {
    public func propertyDescription(entity: NSEntityDescription) -> NSPropertyDescription {
        return Expression.KeyPath(self, nil, nil).propertyDescription(entity)
    }
}

extension NSPropertyDescription : ExpressionType {
    public func propertyDescription(entity: NSEntityDescription) -> NSPropertyDescription {
        return self
    }
}