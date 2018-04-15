//
//  Regex.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/15/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

prefix operator /

public struct Regex: CustomStringConvertible {
    
    public let description: String
    
    public init(_ string: String) {
        description = string
    }

}

public func regex(_ string: String) -> Regex {
    return Regex(string)
}

public prefix func /(string: String) -> Regex {
    return Regex(string)
}
