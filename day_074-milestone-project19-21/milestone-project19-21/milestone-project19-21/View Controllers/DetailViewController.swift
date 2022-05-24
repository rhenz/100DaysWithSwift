//
//  DetailViewController.swift
//  milestone-project19-21
//
//  Created by John Salvador on 5/24/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: NoteViewModel
    
    // MARK: - Init
    init?(coder: NSCoder, viewModel: NoteViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:country:)` to initialize an `DetailViewController` instance.")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
