//
//  SelectionViewController.swift
//  Project30
//
//  Created by TwoStraws on 20/08/2016.
//  Copyright (c) 2016 TwoStraws. All rights reserved.
//

import UIKit

class SelectionViewController: UITableViewController {
	var items = [String]() // this is the array that will store the filenames to load
	var dirty = false
    
    var generatedImages: [UIImage] = []
    
    let renderRect = CGRect(origin: .zero, size: CGSize(width: 90, height: 90))

    override func viewDidLoad() {
        super.viewDidLoad()

		title = "Reactionist"

		tableView.rowHeight = 90
		tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

		// load all the JPEGs into our array
		let fm = FileManager.default
        guard let resourcePath = Bundle.main.resourcePath else { return }

		if let tempItems = try? fm.contentsOfDirectory(atPath: resourcePath) {
			for item in tempItems {
				if item.range(of: "Large") != nil {
					items.append(item)
				}
			}
		}
        
        // create images
        generateImages()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if dirty {
			// we've been marked as needing a counter reload, so reload the whole table
			tableView.reloadData()
		}
	}
    
    // MARK: - Helper Methods
    func generateImages() {
        // find the image for this cell, and load its thumbnail
        for item in items {
            let currentImage = item
            let imageRootName = currentImage.replacingOccurrences(of: "Large", with: "Thumb")
            
            guard let path = Bundle.main.path(forResource: imageRootName, ofType: nil),
                  let original = UIImage(contentsOfFile: path)
            else {
                return
            }

            let renderer = UIGraphicsImageRenderer(size: renderRect.size)

            let rounded = renderer.image { ctx in
                ctx.cgContext.addEllipse(in: renderRect)
                ctx.cgContext.clip()

                original.draw(in: renderRect)
            }
            
            generatedImages.append(rounded)
        }
    }

    // MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return generatedImages.count * 10
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		
        
        cell.imageView?.image = generatedImages[indexPath.item % generatedImages.count]

        // give the images a nice shadow to make them look a bit more dramatic
        cell.imageView?.layer.shadowColor = UIColor.black.cgColor
        cell.imageView?.layer.shadowOpacity = 1
        cell.imageView?.layer.shadowRadius = 10
        cell.imageView?.layer.shadowOffset = CGSize.zero
        cell.imageView?.layer.shadowPath = UIBezierPath(ovalIn: renderRect).cgPath

		// each image stores how often it's been tapped
		let defaults = UserDefaults.standard
        cell.textLabel?.text = "\(defaults.integer(forKey: items[indexPath.item % generatedImages.count]))"

		return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = ImageViewController()
		vc.image = items[indexPath.row % generatedImages.count]
		vc.owner = self

		// mark us as not needing a counter reload when we return
		dirty = false

		// add to our view controller cache and show
		navigationController?.pushViewController(vc, animated: true)
	}
}
