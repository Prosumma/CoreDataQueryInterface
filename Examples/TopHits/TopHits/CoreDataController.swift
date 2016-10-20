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

import Foundation
import CoreData
import CoreDataQueryInterface

class CoreDataController {
    static let ProgressNotification = "CoreDataControllerProgressNotification"
    static let sharedInstance = CoreDataController()
    
    fileprivate init() {}
    
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    func setup(_ completion: @escaping () -> Void) {
        let databaseFileName = "TopHits.db"
        let fileManager = FileManager.default
        let documentPath = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let databasePath = documentPath.appendingPathComponent(databaseFileName)
        let shouldCreateDatabase = !fileManager.fileExists(atPath: databasePath.path)
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: databasePath, options: nil)
        let finish: () -> Void = {
            self.managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            completion()
        }
        if shouldCreateDatabase {
            createDatabase(databasePath, persistentStoreCoordinator: persistentStoreCoordinator, completion: finish)
        } else {
            finish()
        }
    }
    
    fileprivate func createDatabase(_ path: URL, persistentStoreCoordinator: NSPersistentStoreCoordinator, completion: @escaping () -> Void) {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.perform {
            let YEAR = 0
            let POSITION = 1
            let ARTIST = 2
            let SONG = 3
            let FIELD_COUNT = 4
            
            let numberFormatter = NumberFormatter()
            let dataPath = Bundle.main.path(forResource: "TopHits", ofType: "psv")!
            let data = try! String(contentsOfFile: dataPath)
            var previousYear: NSNumber? = nil
            for line in data.components(separatedBy: "\n") {
                let fields = line.components(separatedBy: "|")
                if fields.count != FIELD_COUNT { continue }
                let year = numberFormatter.number(from: fields[YEAR])!
                if year != previousYear {
                    DispatchQueue.main.async {
                        let userInfo = ["year": year]
                        NotificationCenter.default.post(name: Notification.Name(rawValue: CoreDataController.ProgressNotification), object: self, userInfo: userInfo)
                    }
                    previousYear = year
                }
                let position = numberFormatter.number(from: fields[POSITION])!
                let artistName = fields[ARTIST]
                let songName = fields[SONG]
                let artist = try! managedObjectContext.from(Artist.self).filter({$0.name == artistName}).first() ?? managedObjectContext.cdqiNewEntity(Artist.self)
                artist.name = artistName
                let song = managedObjectContext.cdqiNewEntity(Song.self)
                song.year = Int32(year.intValue)
                song.position = Int32(position.intValue)
                song.name = songName
                song.artist = artist
            }
            try! managedObjectContext.save()
            DispatchQueue.main.async(execute: completion)
        }
    }
}
