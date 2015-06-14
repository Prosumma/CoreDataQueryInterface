//
//  PropertyType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol PropertyType {
    func toPropertyDescription(entityDescription: NSEntityDescription) -> NSPropertyDescription
}