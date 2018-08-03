//
//  Typed.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/// Surfaces the `NSAttributeType` of the implementing instance.
public protocol Typed {
    /// The `NSAttributeType` of this instance.
    var cdqiType: NSAttributeType { get }
}
