//
//  DetailViewController.swift
//  milestone-project13-15
//
//  Created by John Salvador on 5/11/22.
//

import UIKit

class DetailViewController: UITableViewController {
    
    // MARK: - Stored Properties
    private var country: Country
    private typealias TableSection = Country.TableSection
    
    init?(coder: NSCoder, country: Country) {
        self.country = country
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:country:)` to initialize an `DetailViewController` instance.")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = country.name
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return TableSection.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        
        guard let section = TableSection.init(rawValue: indexPath.section) else {
            fatalError("Failed to initialize table view sections")
        }
        
        // Setup Cell
        var content = cell.defaultContentConfiguration()
        
        
        switch section {
        case .name:
            content.text = country.name
        case .code:
            content.text = country.code
        case .capital:
            content.text = country.code
        case .totalLandArea:
            content.text = "\(country.totalLandArea) km2"
        case .population:
            content.text = "\(country.population)"
        case .currency:
            content.text = country.currency
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TableSection.init(rawValue: section)?.sectionTitle ?? ""
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
