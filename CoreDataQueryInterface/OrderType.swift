//
//  OrderType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol OrderType {
    func sortDescriptor(ascending ascending: Boolean) -> NSSortDescriptor
}