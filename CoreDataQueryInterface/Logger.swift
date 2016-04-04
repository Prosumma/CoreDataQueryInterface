//
//  Logger.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/4/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

struct Logger {
    private static var enabled: Bool = {
        NSProcessInfo().arguments.filter{ $0 == "-com.prosumma.CoreDataQueryInterface.Debug" }.count > 0
    }()
    
    private static var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return dateFormatter
    }()
    
    static func log(message: String) {
        if !enabled { return }
        let date = dateFormatter.stringFromDate(NSDate())
        print("\(date) CoreDataQueryInterface: \(message)")
    }
    
    static func log(fetchRequest: NSFetchRequest) {
        var info = [String]()
        if let entityName = fetchRequest.entityName {
            info.append("entity: \(entityName)")
        }
        if let predicate = fetchRequest.predicate {
            info.append("predicate: \(predicate)")
        }
        if let sortDescriptors = fetchRequest.sortDescriptors where sortDescriptors.count > 0 {
            info.append("sortDescriptors: \(sortDescriptors)")
        }
        if fetchRequest.fetchLimit > 0 {
            info.append("limit: \(fetchRequest.fetchLimit)")
        }
        let type: String
        switch fetchRequest.resultType {
        case NSFetchRequestResultType.CountResultType: type = ".CountResultType"
        case NSFetchRequestResultType.DictionaryResultType: type = ".DictionaryResultType"
        case NSFetchRequestResultType.ManagedObjectIDResultType: type = ".ManagedObjectIDResultType"
        default: type = ".ManagedObjectResultType"
        }
        info.append("type: \(type)")
        log(info.joinWithSeparator(" "))
    }
}