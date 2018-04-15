//
//  Typed.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol Typed {
    var cdqiType: NSAttributeType { get }
}
