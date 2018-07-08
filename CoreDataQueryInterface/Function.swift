//
//  Function.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

/**
 A convenience protocol that groups those protocols
 that a function must support.
 */
public protocol Function: Inconstant, Typed, TypeComparable, Expression, Named {}
