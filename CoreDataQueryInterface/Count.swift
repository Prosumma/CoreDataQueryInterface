//
//  Count.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/**
 A type that generates a Core Data expression to count its wrapped expression.
 
 Use the `count` function and `cdqiCount` attribute to create an instance of `Count`.
 
 ```
 Employee.e.cdqiQuery
    .group(by: Employee.e.department.name)
    .select(
        Employee.e.department.name,
        Employee.e.cdqiCount
    )
 ```
 */
public struct Count: Function {
    public typealias CDQIComparableType = NSNumber
    
    public let cdqiAttributeType: NSAttributeType = .integer64AttributeType
    public let cdqiName: String
    public let cdqiExpression: NSExpression
    
    init(_ argument: Expression) {
        if let argument = argument as? Named, argument.cdqiName.count > 0 {
            cdqiName = "\(argument.cdqiName)Count"
        } else {
            cdqiName = "count"
        }
        if argument is Subquery {
            cdqiExpression = NSExpression(format: "%@.@count", argument.cdqiExpression)
        } else {
            cdqiExpression = NSExpression(forFunction: "count:", arguments: [argument.cdqiExpression])
        }
    }
}

public func count(_ argument: Expression) -> Count {
    return Count(argument)
}

public extension Expression {
    var cdqiCount: Count {
        return Count(self)
    }
}
