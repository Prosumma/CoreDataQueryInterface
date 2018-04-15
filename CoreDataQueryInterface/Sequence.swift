//
//  Sequence.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

extension Sequence {
    
    func map<K>(_ keyPath: KeyPath<Element, K>) -> [K] {
        return map{ $0[keyPath: keyPath] }
    }
    
}
