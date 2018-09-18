//
//  Int32.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension Int32: Scalar {
    public typealias CDQIComparableType = NSNumber
    
    public var cdqiAttributeType: NSAttributeType {
        return .integer32AttributeType
    }
}
