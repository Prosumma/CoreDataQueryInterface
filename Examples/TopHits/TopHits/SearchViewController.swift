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

import UIKit
import CoreData
import CoreDataQueryInterface
import QuartzCore

class SearchViewController: UITableViewController, UISearchResultsUpdating {
    
    fileprivate var fetchedResultsController: NSFetchedResultsController<Song>!
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate lazy var sortedSongQuery: Query<Song, Song> = { self.managedObjectContext.from(Song.self).order(ascending: false, {song in song.year}).order({song in song.position}) }()
    
    fileprivate var positionImages = [UIImage]()
    
    fileprivate enum SearchScope: String {
        case Title = "Title"
        case Artist = "Artist"
        case Year = "Year"
        case Position = "Position"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont(name: "MarkerFelt-Thin", size: 30)!
        label.text = "Top Hits"
        label.textColor = UIColor.white
        label.sizeToFit()
        navigationItem.titleView = label
        
        toolbarItems = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Sort", style: .plain, target: nil, action: nil)]
        
        tableView.estimatedRowHeight = 68;
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.scopeButtonTitles = [SearchScope.Title.rawValue, SearchScope.Artist.rawValue, SearchScope.Year.rawValue, SearchScope.Position.rawValue]
        searchController.searchBar.tintColor = UIColor(red: 45/255, green: 119/255, blue: 166/255, alpha: 0.8)
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        let dimension: CGFloat = 50
        for p: Int32 in 1...100 {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: dimension, height: dimension), false, UIScreen.main.scale)
            var rect = CGRect(x: 0, y: 0, width: dimension, height: dimension)
            let bezierPath = UIBezierPath(ovalIn: rect)
            UIColor(red: 45/255, green: 119/255, blue: 166/255, alpha: 0.6).setFill()
            bezierPath.fill()
            let position = String(p) as NSString
            var attributes = [String: AnyObject]()
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            attributes[NSParagraphStyleAttributeName] = paragraph
            let font = UIFont.boldSystemFont(ofSize: 22)
            attributes[NSFontAttributeName] = font
            attributes[NSForegroundColorAttributeName] = UIColor.white
            rect.origin.y = rect.midY - font.lineHeight / 2
            position.draw(in: rect, withAttributes: attributes)
            positionImages.append(UIGraphicsGetImageFromCurrentImageContext()!)
            UIGraphicsEndImageContext()
        }

        performSearch(nil)
    }
    
    fileprivate func getSearchFilter(_ criteria: String, scope: SearchScope) -> NSPredicate {
        let song = Song.CDQIAttribute()
        let options: NSComparisonPredicate.Options = [.caseInsensitive, .diacriticInsensitive]
        switch scope {
        case .Title:
            return song.name.cdqiContains(criteria, options: options)
        case .Artist:
            return song.artist.name.cdqiContains(criteria, options: options)
        case .Year:
            guard let year = NumberFormatter().number(from: criteria) else {
                return NSPredicate(value: false)
            }
            return song.year == year
        case .Position:
            guard let position = NumberFormatter().number(from: criteria) else {
                return NSPredicate(value: false)
            }
            return song.position == position
        }
    }
    
    fileprivate func performSearch(_ criteria: String?) {
        let songQuery: Query<Song, Song>
        if let criteria = criteria {
            let scope = SearchScope(rawValue: searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex])!
            songQuery = sortedSongQuery.filter(getSearchFilter(criteria, scope: scope))
        } else {
            songQuery = sortedSongQuery
        }
        let request = songQuery.request()
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        try! fetchedResultsController.performFetch()
        tableView.reloadData()
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        if let criteria = searchController.searchBar.text , criteria.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count > 0 {
            performSearch(criteria)
        } else {
            performSearch(nil)
        }
    }
    
    // MARK: - UITableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "song", for: indexPath) as! SongTableViewCell
        let song = fetchedResultsController.object(at: indexPath) 
        cell.titleLabel.text = song.name
        cell.artistLabel.text = song.artist.name
        cell.yearLabel.text = String(song.year)
        cell.positionImageView.image = positionImages[song.position - 1]
        return cell
    }
    
}
