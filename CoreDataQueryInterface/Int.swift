//
//  Int.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension Int: Scalar {
    public typealias CDQIComparableType = NSNumber
    
    public var cdqiType: NSAttributeType {
        switch MemoryLayout<Int>.size {
        case 2: return .integer16AttributeType
        case 4: return .integer32AttributeType
        case 8: return .integer64AttributeType
        default: return .undefinedAttributeType
        }
    }
}


