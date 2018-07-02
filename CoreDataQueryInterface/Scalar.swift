//
//  Scalar.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/// A convenience protocol for scalars such as `String`, `Int`, `Double`, etc.
public protocol Scalar: Typed, TypeComparable, ConstantExpression {}
