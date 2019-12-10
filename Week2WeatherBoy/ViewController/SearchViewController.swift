//
//  ViewController.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/9/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    //--------------------------------------------------------------
    //MARK: Properties
    
    // container to hold cities
    var cities = [City]() {
        didSet {// runs block of functionality AFTER the property's value has been set
            orderedCities = order(cities)   // set ordered cities
        }
    }
    
    // Alphabetizing
    var orderedCities: [String: [City]] = [:] { // Add an observer
        didSet {
            DispatchQueue.main.async{ // go to main thread
                self.searchTableView.reloadData() // reload table view
            }
        }
    }
    
    var filteredCities = [City]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var isFiltering: Bool {
        return !searchController.searchBar.text!.isEmpty && searchController.isActive
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
    }
    
    //--------------------------------------------------------------
    
    //MARK: Search
    private func loadSearchView() {
        // update out search controller
        searchController.hidesNavigationBarDuringPresentation = false // shows search bar immediately
        navigationItem.hidesSearchBarWhenScrolling = false // hide search bar while scrolling
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController // set delegate to view controller class
        
        // find our navigation controller
        navigationItem.searchController = searchController
    }
    
    private func filter(with search: String) {
        filteredCities = [] // clear array
        
        for city in cities {
            if city.state.contains(search) || city.name.contains(search) {
                filteredCities.append(city)
            }
        }
        
        searchTableView.reloadData()
    }
    
    //MARK: Sort
    
    
    //MARK: Funcitonality
    private func setupSearch() {
        get()
        loadSearchView()
        searchTableView.tableFooterView = UIView(frame: .zero) // remove unused table cells
    }
    
    private func get() {
        CityManager.shared.getCities { [weak self] cits in      // capture list of closure
            self?.cities = cits
            print ("City count: \(cits.count)")
        }
    }
    
    // takes a parameter that is an array of cities
    // returns a string of type City
    private func order(_ cities: [City]) -> [String: [City]] {
        
        /// LONG WAY
        ///var cityDict = [String: [City]]()
        
        // Short-hand way
        var cityDict = Dictionary(grouping: cities, by: {$0.name.first!.uppercased()})
        // $0 means not naming the local var in a for loop
        
        //let mainDict = Dictionary(grouping: cities) { (cty) -> Stirng in
        //    return cty.name.first!.uppercased()
        //}
        
        ///LONG WAY
        // loop through parameter cities
        /**
         for city in cities {
            let letter = city.name.first!.uppercased()
            if cityDict[letter] != nil {
                // we can unwrap with ! because we aready determined it's not nil
                cityDict[letter]!.append(city)
            } else {
                cityDict[letter] = [city]
            }
        }**/
        
        // loop through city dictionary, sort the city array for each key into ABC order
        for (key, value) in cityDict {
            cityDict[key] = value.sorted(by: { (cityOne, cityTwo) -> Bool in
                cityOne.name < cityTwo.name
            })
        }
        
        return cityDict
    }
    
    // helper function
    private func getCities(from section: Int) -> [City] {
        // put keys in ascending order
        let keys = orderedCities.keys.sorted(by: {$0 < $1})
        let key = keys[section] // get correct key from section
        return orderedCities[key]! // force unwrap, get cities from key
    }
}
//MARK: TableView
extension SearchViewController: UITableViewDataSource {
    
    // returns int
    func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ? 1 : orderedCities.keys.count
    }
    
    // tells the table view how many rows to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCities.count : getCities(from: section).count
    }
    
    // Handles the rendering of the rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellOne.identifier, for: indexPath) as! TableCellOne
        let cities = isFiltering ? filteredCities : getCities(from: indexPath.section)
        let city = cities[indexPath.row] // subscript to get the correct city for row
        cell.mainLabel.text = "\(city.name), \(city.state)"
        let pop = city.population.addCommas ?? "0" // nil-coalescing - give default value to optional
        cell.subLabel.text = "Population: \(pop)" // set sub label
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    // controls height for each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // controls ABD side bar section index titles (side bar letters)
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return isFiltering ? nil : orderedCities.keys.sorted(by: {$0 < $1}) // get keys from dictionary
    }
    
    // controls headers for each section of table view
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keys = orderedCities.keys.sorted(by: {$0 < $1})
        return isFiltering ? "Cities" : keys[section] // get correct key for section
    }
    
    // controls touch events on table view cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // deselect after tap
    }
    
}

//MARK: Search Bar
extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
        
        //let search = searchController.
    }
}
