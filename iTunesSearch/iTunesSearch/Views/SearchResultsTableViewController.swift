//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Joseph Rogers on 11/1/19.
//  Copyright © 2019 Joseph Rogers. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var limitSearchButton: UIBarButtonItem!
    
    let searchResultsController = SearchResultController()
    var resultType: ResultType!
    var limit: Int = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)

        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        return cell
    }
    
    //MARK: Actions
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        if limitSearchButton.title == "show more" {
            limitSearchButton.title = "show less"
        } else {
            limitSearchButton.title = "show more"
        }
        
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            searchBarSearchButtonClicked(searchBar)
            self.tableView.reloadData()
        }else if sender.selectedSegmentIndex == 1 {
             searchBarSearchButtonClicked(searchBar)
            self.tableView.reloadData()
        }else {
             searchBarSearchButtonClicked(searchBar)
            self.tableView.reloadData()
        }
    }
    
    
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            break
        }
                searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
    }
}
