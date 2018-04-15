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
    
    init(_ argument: Expression & Typed) {
        cdqiType = argument.cdqiType
        if let named = argument as? Named {
            cdqiName = "\(named.cdqiName)Sum"
        } else {
            cdqiName = "Sum"
        }
        cdqiExpression = NSExpression(forFunction: "sum:", arguments: [argument.cdqiExpression])
    }
}

public func sum(_ argument: Expression & Typed) -> Sum {
    return Sum(argument)
}

public extension Expression where Self: Typed {
    var cdqiSum: Sum {
        return Sum(self)
    }
}
