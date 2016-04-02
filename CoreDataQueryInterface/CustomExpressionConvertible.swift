//
//  CustomExpressionConvertible.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 12/28/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

public protocol CustomExpressionConvertible {
    var expression: NSExpression { get }
}

extension NSExpression: CustomExpressionConvertible {
    public var expression: NSExpression {
        return self
    }
}
