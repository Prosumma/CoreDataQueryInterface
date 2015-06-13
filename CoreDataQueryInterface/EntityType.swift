//
//  ManagedObjectType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol EntityType: class {
//    typealias EntityAttributedType: AttributedType
    static var entityName: String { get }
}

extension EntityType {
    public static var entityName: String {
        return ""
    }
}
