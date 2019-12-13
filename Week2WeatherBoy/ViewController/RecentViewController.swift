//
//  RecentViewController.swift
//  Week2WeatherBoy
//
//  Created by Consultant on 12/9/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController {
    
    @IBOutlet weak var recentTableView: UITableView!
    
    var cities = [City]() {
        didSet {    // property observer - causes auto reload everytime the cities changes it calls this block of functionality
            // a.k.a. data binding (property observer + )
            DispatchQueue.main.async {
                self.recentTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cities = CityManager.shared.load() // get cities form the CoreData
    }
    
    private func setupRecent() {
        title = "Recent Cities"
        recentTableView.tableFooterView = UIView(frame: .zero) // remove empty cells
        recentTableView.register(UINib(nibName: CityTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: CityTableCell.identifier) // register XIB cell to table
        cities = CityManager.shared.load()
    }
}

extension RecentViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as! CityTableCell
        
        // get correct city for the row
        let city = cities[indexPath.row]
        cell.cityName.text = "\(city.name), \(city.state)"
        let population = city.population.addCommas ?? "0"
        cell.cityPopulation.text = "Population: \(population)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let city = cities[indexPath.row]
            CityManager.shared.delete(city) // delete city from CoreData
            cities.remove(at: indexPath.row) // remove city form array (data source)

            //Reload table view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
