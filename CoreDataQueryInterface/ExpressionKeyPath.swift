//
//  ExpressionKeyPath.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public enum ExpressionKeyPath: CustomStringConvertible {
    case root
    case variable(String)
    case keyPath(String, KeyPathExpression)
    
    public var description: String {
        switch self {
        case .root:
            return "SELF"
        case .variable(let variable):
            return "$\(variable)"
        case let .keyPath(key, parent):
            let parentKeyPath = String(describing: parent.cdqiExpressionKeyPath)
            return parentKeyPath == "SELF" ? key : "\(parentKeyPath).\(key)"
        }
    }
}

