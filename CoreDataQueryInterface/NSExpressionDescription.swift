//
//  NSExpressionDescription.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/14/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension NSExpressionDescription {
    
    convenience init(expression: Property) {
        self.init()
        self.name = expression.cdqiName
        self.expression = expression.cdqiExpression
        self.expressionResultType = expression.cdqiAttributeType
    }
    
}
