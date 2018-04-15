//
//  KeyPathExpression.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol KeyPathExpression: Expression, Named {
    var cdqiExpressionKeyPath: ExpressionKeyPath { get }
}

public extension KeyPathExpression {
    var cdqiExpression: NSExpression {
        let keyPath = cdqiKeyPath
        return keyPath == "SELF" ? NSExpression(format: "SELF") : NSExpression(forKeyPath: keyPath)
    }
    
    var cdqiKeyPath: String {
        return String(describing: cdqiExpressionKeyPath)
    }
    
    var cdqiVariable: String? {
        guard case .variable(let variable) = cdqiExpressionKeyPath else { return nil }
        return variable
    }
    
    var cdqiName: String {
        switch cdqiExpressionKeyPath {
        case .root:
            return ""
        case .variable:
            assertionFailure("Variable keypaths cannot have names")
            return ""
        case let .keyPath(key, parent):
            let parentName = parent.cdqiName
            return parentName == "" ? key : "\(parentName)\(key.titlecased())"
        }
    }
}
