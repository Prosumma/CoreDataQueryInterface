//
//  Decimal.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension Decimal: Scalar {
    public typealias CDQIComparableType = NSNumber
    
    public var cdqiType: NSAttributeType {
        return .decimalAttributeType
    }
}
