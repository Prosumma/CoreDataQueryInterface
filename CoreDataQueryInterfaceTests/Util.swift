//
//  Util.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/21/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension SequenceType {
    func toDictionary<Key: Hashable, Value>(transform: Generator.Element -> (Key, Value)) -> Dictionary<Key, Value> {
        var result = Dictionary<Key, Value>()
        for elem in self {
            let (key, value) = transform(elem)
            result[key] = value
        }
        return result
    }
}
