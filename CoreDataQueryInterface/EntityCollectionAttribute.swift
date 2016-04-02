//
//  EntityCollectionAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 3/31/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData


extension NSManagedObject: ExpressionValueType {
    
    public var expressionValue: AnyObject {
        
        return self
    }
}

extension Set: ExpressionValueType {
    
    public var expressionValue: AnyObject {
        
        return map({ element -> AnyObject in
            
            switch element {
                
            case let object as AnyObject: return object
            case let valueType as ExpressionValueType: return valueType.expressionValue
            default: return "\(element)"
            }
        })
    }
}

public class EntityCollectionAttribute<T: NSManagedObject where T: EntityType>: Attribute, Aggregable, TypedExpressionConvertible {
    
    public typealias ValueType = Set<T>
    public typealias AggregateType = T.EntityAttributeType
    
    public required init(_ name: String, parent: Attribute?) {
        super.init(name, parent: parent)
    }
}