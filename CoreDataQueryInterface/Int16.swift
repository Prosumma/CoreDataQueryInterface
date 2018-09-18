//
//  Int16.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension Int16: Scalar {
    public typealias CDQIComparableType = NSNumber
    
    public var cdqiAttributeType: NSAttributeType {
        return .integer16AttributeType
    }
}
