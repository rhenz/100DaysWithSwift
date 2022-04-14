//
//  ShoppingListViewController.swift
//  Day32-Milestone-Project
//
//  Created by JLCS on 4/13/22.
//

import UIKit

class ShoppingListViewController: UITableViewController {
    
    // MARK: - Stored Properties
    private var shoppingList: [String] = []
    private let shoppingItemCellIdentifier = "shoppingItemCell"

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods
    private func setupView() {
        self.title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddShoppingItemAlert))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(deleteAllShoppingItems))
    }
    
    @objc
    private func presentAddShoppingItemAlert() {
        let ac = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "shopping item"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let shoppingItem = ac.textFields?[0].text, !shoppingItem.isEmpty {
                self.addShoppingItem(shoppingItem)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(cancelAction)
        ac.addAction(addAction)
        
        present(ac, animated: true)
    }
    
    @objc
    private func deleteAllShoppingItems() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    private func addShoppingItem(_ item: String) {
        shoppingList.append(item)
        let indexPath = IndexPath(row: shoppingList.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - Table View Datasource
extension ShoppingListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingItemCellIdentifier, for: indexPath)
        
        // Setup cell
        var content = cell.defaultContentConfiguration()
        content.text = shoppingList[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Table View Delegate
extension ShoppingListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
