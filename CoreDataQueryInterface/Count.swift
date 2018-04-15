//
//  Count.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct Count: Function {
    public typealias CDQIComparableType = NSNumber
    
    public let cdqiType: NSAttributeType = .integer64AttributeType
    public let cdqiName: String
    public let cdqiExpression: NSExpression
    
    public init(_ argument: Expression) {
        if let named = argument as? Named {
            cdqiName = "\(named.cdqiName)Count"
        } else {
            cdqiName = "Count"
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
