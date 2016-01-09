//
//  SearchViewController.swift
//  TopHits
//
//  Created by Gregory Higley on 1/3/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import UIKit
import CoreData
import CoreDataQueryInterface
import QuartzCore

class SearchViewController: UITableViewController, UISearchResultsUpdating {
    
    private var fetchedResultsController: NSFetchedResultsController!
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var sortedSongQuery: EntityQuery<Song> = { self.managedObjectContext.from(Song).order(descending: {song in song.year}).order({song in song.position}) }()
    
    private var positionImages = [UIImage]()
    
    private enum SearchScope: String {
        case Title = "Title"
        case Artist = "Artist"
        case Year = "Year"
        case Position = "Position"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRectZero)
        label.font = UIFont(name: "MarkerFelt-Thin", size: 30)!
        label.text = "Top Hits"
        label.textColor = UIColor.whiteColor()
        label.sizeToFit()
        navigationItem.titleView = label
        
        toolbarItems = [UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Sort", style: .Plain, target: nil, action: nil)]
        
        tableView.estimatedRowHeight = 68;
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .None
        searchController.searchBar.autocorrectionType = .No
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeButtonTitles = [SearchScope.Title.rawValue, SearchScope.Artist.rawValue, SearchScope.Year.rawValue, SearchScope.Position.rawValue]
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        let dimension: CGFloat = 50
        for p: Int32 in 1...100 {
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(dimension, dimension), false, UIScreen.mainScreen().scale)
            var rect = CGRectMake(0, 0, dimension, dimension)
            let bezierPath = UIBezierPath(ovalInRect: rect)
            UIColor(red: 45/255, green: 119/255, blue: 166/255, alpha: 0.6).setFill()
            bezierPath.fill()
            let position = String(p) as NSString
            var attributes = [String: AnyObject]()
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .Center
            attributes[NSParagraphStyleAttributeName] = paragraph
            let font = UIFont.boldSystemFontOfSize(22)
            attributes[NSFontAttributeName] = font
            attributes[NSForegroundColorAttributeName] = UIColor.whiteColor()
            rect.origin.y = CGRectGetMidY(rect) - font.lineHeight / 2
            position.drawInRect(rect, withAttributes: attributes)
            positionImages.append(UIGraphicsGetImageFromCurrentImageContext())
            UIGraphicsEndImageContext()
        }

        performSearch(nil)
    }
    
    private func getSearchFilter(criteria: String, scope: SearchScope) -> NSPredicate {
        let song = Song.EntityAttributeType()
        let options: NSComparisonPredicateOptions = [.CaseInsensitivePredicateOption, .DiacriticInsensitivePredicateOption]
        switch scope {
        case .Title:
            return song.name.contains(criteria, options: options)
        case .Artist:
            return song.artist.name.contains(criteria, options: options)
        case .Year:
            guard let year = NSNumberFormatter().numberFromString(criteria) else {
                return NSPredicate(value: false)
            }
            return song.year == year
        case .Position:
            guard let position = NSNumberFormatter().numberFromString(criteria) else {
                return NSPredicate(value: false)
            }
            return song.position == position
        }
    }
    
    private func performSearch(criteria: String?) {
        let songQuery: EntityQuery<Song>
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
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let criteria = searchController.searchBar.text where criteria.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).characters.count > 0 {
            performSearch(criteria)
        } else {
            performSearch(nil)
        }
    }
    
    // MARK: - UITableView
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("song", forIndexPath: indexPath) as! SongTableViewCell
        let song = fetchedResultsController.objectAtIndexPath(indexPath) as! Song
        cell.titleLabel.text = song.name
        cell.artistLabel.text = song.artist.name
        cell.yearLabel.text = String(song.year)
        cell.positionImageView.image = positionImages[song.position - 1]
        return cell
    }
    
}
