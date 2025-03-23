//
//  HeroTableViewController.swift
//  MVVMProject
//
//  Created by Jan Petrina on 21/03/2025.
//

import UIKit

class HeroTableViewController: UIViewController {
    
    private let viewModel: HeroTableViewModel
    
    init(viewModel: HeroTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HeroTableView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("Noooooo, salio fatal error :(")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
