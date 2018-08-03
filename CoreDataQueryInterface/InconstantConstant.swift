//
//  InconstantConstant.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

#warning("Rename this!")

public struct InconstantConstant<E: Expression & TypeComparable>: Expression, Inconstant, TypeComparable {
    public typealias CDQIComparableType = E.CDQIComparableType
    
    public let cdqiExpression: NSExpression
    
    public init(_ constant: E) {
        cdqiExpression = constant.cdqiExpression
    }
}

public func inconstant<E: Expression & TypeComparable>(_ constant: E) -> InconstantConstant<E> {
    return InconstantConstant(constant)
}

