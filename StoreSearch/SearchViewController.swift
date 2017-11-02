//
//  ViewController.swift
//  StoreSearch
//
//  Created by Gabriel Breshears on 10/15/17.
//  Copyright © 2017 Gabriel Breshears. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableview: UITableView!
    var searchResults = [SearchResult]()
    var hasSearched: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //searchBar.delegate = self
        
        tableview.contentInset = UIEdgeInsets(top: 64,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResults = [SearchResult]()
        hasSearched = true
        if searchBar.text!.lowercased() != "justin bieber"{
            for i in 0...2{
                let searchResult = SearchResult()
                searchResult.name = String(format: "Fake result %d for", i)
                searchResult.artistName = searchBar.text!
                searchResults.append(searchResult)
            }
            print("The search text is \(searchBar.text!)")
            tableview.reloadData()
            searchBar.resignFirstResponder()
        }else {
            tableview.reloadData()
        }
    }
    // THIS SHIT MAKES THE Search bar and the status bar look good together.
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !hasSearched{
            print("\(!hasSearched)")
            return 0
        } else if searchResults.count == 0 {
            return 1
        }else {
            return searchResults.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier: String = "SearchResultCell"
        
        var cell: UITableViewCell! = tableview.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        if searchResults.count == 0{
            cell.textLabel!.text = "(Nothing found)"
            cell.detailTextLabel!.text = ""
        } else {
            let searchResult = searchResults[indexPath.row]
            cell.textLabel?.text = searchResult.name
            cell.detailTextLabel?.text = searchResult.artistName
            
        }
        
        return cell
    }
    // Deselects the cell with a animation! COOL AS FUCK!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //This makes sure you cant select when the tableview is empty
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    
    
    
}

