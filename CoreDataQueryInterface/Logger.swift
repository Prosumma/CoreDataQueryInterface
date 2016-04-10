/*
The MIT License (MIT)

Copyright (c) 2015 Gregory Higley (Prosumma)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import CoreData
import Foundation

struct Logger {
    private static var enabled: Bool = { NSProcessInfo().arguments.contains("-com.prosumma.CoreDataQueryInterface.Debug") }()
    
    static func log(message: String) {
        if !enabled { return }
        NSLog("CoreDataQueryInterface: %@", message)
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
        if let propertiesToGroupBy = fetchRequest.propertiesToGroupBy where propertiesToGroupBy.count > 0 {
            info.append("groupBy: \(propertiesToGroupBy)")
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
