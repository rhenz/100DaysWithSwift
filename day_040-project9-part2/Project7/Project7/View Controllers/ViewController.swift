//
//  ViewController.swift
//  Project7
//
//  Created by JLCS on 4/14/22.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Stored Properties
    var petitions: [Petition] = []
    var filteredPetitions: [Petition] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        preparePetitionsData()
    }
    
    // MARK: - Private Methods
    private func preparePetitionsData() {
        var urlString: String
        switch navigationController?.tabBarItem.tag {
        case 0:
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        case 1:
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        default:
            urlString = ""
        }
        //        if Int.random(in: 1...2) == 1 { urlString = "" } // Just to test the error alert view
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(jsonData: data)
                    return
                }
            }
            
            // Parsing above wasn't successful
            self.showError()
        }
    }
    
    private func setupView() {
        title = "Petitions"
        tableView.estimatedRowHeight = 0
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCreditsAlert))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilterAlert))
    }
    
    private func parse(jsonData: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: jsonData) {
            petitions = jsonPetitions.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            DispatchQueue.main.async {
                self.showError()
            }
        }
    }
    
    private func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    @objc
    private func showCreditsAlert() {
        let ac = UIAlertController(title: "Notice", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    @objc
    private func showFilterAlert() {
        let ac = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "enter text to filter"
        }
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            if let filterText = ac.textFields?[0].text, !filterText.isEmpty {
                // Filter table view according to keywords
                self?.filterPetitions(for: filterText)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(cancelAction)
        ac.addAction(doneAction)
        present(ac, animated: true)
    }
    
    private func filterPetitions(for filterText: String) {
        DispatchQueue.global().async {
            self.filteredPetitions = self.petitions.filter({$0.title.lowercased().contains(filterText.lowercased())})
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Table View Datasource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPetitions.count > 0 ? filteredPetitions.count : petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Setup cell
        let petition = filteredPetitions.count > 0 ? filteredPetitions[indexPath.row] : petitions[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = petition.title
        content.secondaryText = petition.body
        content.textProperties.numberOfLines = 1
        content.secondaryTextProperties.numberOfLines = 1
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Table View Delegater
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailViewController()
        let petition = filteredPetitions.count > 0 ? filteredPetitions[indexPath.row] : petitions[indexPath.row]
        vc.detailItem = petition
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
