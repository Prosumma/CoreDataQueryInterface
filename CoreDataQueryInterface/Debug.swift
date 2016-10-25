//
//  Debug.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 10/25/16.
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
