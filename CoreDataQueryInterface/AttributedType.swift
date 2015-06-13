//
//  AttributedType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol AttributedType: CustomStringConvertible {
    init(name: String?, parent: AttributedType?)
}