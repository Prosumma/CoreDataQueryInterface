//
//  Util.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 10/5/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

var debug: Bool = {
    for arg in ProcessInfo.processInfo.arguments {
        if arg == "-com.prosumma.CoreDataQueryInterface.Debug" {
            return true
        }
    }
    return false
}()

infix operator ??= : AssignmentPrecedence

func ??=<T>(lhs: inout T?, rhs: @autoclosure () -> T?) {
    if lhs != nil { return }
    lhs = rhs()
}

