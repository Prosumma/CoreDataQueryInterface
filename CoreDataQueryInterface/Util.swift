//
//  Util.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 10/5/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

infix operator ??= : AssignmentPrecedence

func ??=<T>(lhs: inout T?, rhs: @autoclosure () -> T?) {
    if lhs != nil { return }
    lhs = rhs()
}

