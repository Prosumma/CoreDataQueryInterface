//
//  String.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension String: Scalar {
    public var cdqiAttributeType: NSAttributeType {
        return .stringAttributeType
    }
}

extension String {
    
    func titlecased() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
}
