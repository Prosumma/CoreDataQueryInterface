//
//  Int64.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension Int64: Scalar {
    public typealias CDQIComparableType = NSNumber
    
    public var cdqiType: NSAttributeType {
        return .integer64AttributeType
    }
}
