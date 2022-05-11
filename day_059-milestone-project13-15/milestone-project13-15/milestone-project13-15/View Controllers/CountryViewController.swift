//
//  CountryViewController.swift
//  milestone-project13-15
//
//  Created by John Salvador on 5/11/22.
//

import UIKit

class CountryViewController: UITableViewController {
    
    // MARK: - Stored Properties
    var countries: [Country] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        loadJSON()
    }
    
    // MARK: - Methods
    private func loadJSON() {
        if let path = Bundle.main.url(forResource: "country", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let jsonData = try JSONDecoder().decode([Country].self, from: data)
                countries = jsonData
            } catch {
                print("ERROR: \(error)")
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        
        // Setup Cell
        var content = cell.defaultContentConfiguration()
        let country = countries[indexPath.item]
        content.text = country.name
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetailVC(countries[indexPath.item])
    }
    
    private func showDetailVC(_ country: Country) {
        // Initialize Image View Controller
        let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "DetailViewController", creator: { coder -> DetailViewController? in
            DetailViewController(coder: coder, country: country)
        })
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


