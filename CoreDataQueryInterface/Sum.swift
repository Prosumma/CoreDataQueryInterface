//
//  Sum.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct Sum: Function {
    public typealias CDQIComparableType = NSNumber
    
    public let cdqiType: NSAttributeType
    public let cdqiName: String
    public let cdqiExpression: NSExpression
    
    init(_ argument: Property) {
        cdqiType = argument.cdqiType
        cdqiName = "\(argument.cdqiName)Sum"
        cdqiExpression = NSExpression(forFunction: "sum:", arguments: [argument.cdqiExpression])
    }
}

public func sum(_ argument: Property) -> Sum {
    return Sum(argument)
}

public extension Expression where Self: Typed & Named {
    var cdqiSum: Sum {
        return Sum(self)
    }
}
