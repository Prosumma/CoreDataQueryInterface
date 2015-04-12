//
//  EntityMetadata.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/10/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation

/*! The protocol which all managed objects must implement to participate in CDQI. */
/*
    Strictly speaking, this protocol should not be necessary. Adding an entityName method to
    NSManagedObject should be sufficient on its own. Unfortunately that approach causes
    an ugly compiler bug to surface, in which the compiler gets confused about which overload
    of a method to use. Until that bug is fixed, this protocol is needed.
*/
public protocol EntityMetadata {
    static var entityName: String { get }
}

