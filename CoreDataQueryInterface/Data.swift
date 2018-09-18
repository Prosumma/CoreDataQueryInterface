//
//  Data.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension Data: Scalar {
    public var cdqiAttributeType: NSAttributeType {
        return .binaryDataAttributeType
    }
}
