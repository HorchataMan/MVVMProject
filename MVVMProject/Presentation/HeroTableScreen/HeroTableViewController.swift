//
//  HeroTableViewController.swift
//  MVVMProject
//
//  Created by Jan Petrina on 21/03/2025.
//

import UIKit

class HeroTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var errorSV: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var heroTable: UITableView!
    
    private let viewModel: HeroTableViewModel
    
    init(viewModel: HeroTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HeroTableView", bundle: Bundle(for: type(of: self)))
    }
    
    @IBAction func retryButtonTapped(_ sender: UIButton) {
        viewModel.getHeroes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Noooooo, salio fatal error :(")
    }
    
    func bind() {
        viewModel.stateMachine.bind { [weak self] result in
            switch result {
            case .loading: self?.onLoading()
            case .done: self?.onDone()
            case .error(let reason): self?.onError(reason: reason)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.getHeroes()
        heroTable.delegate = self
        heroTable.dataSource = self
        heroTable.register(UINib(nibName: "HeroCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: HeroCell.reuseIdentifier)
    }
    
    func onLoading() {
        heroTable.isHidden = true
        activityIndicator.startAnimating()
        errorSV.isHidden = true
        
    }
    
    func onDone() {
        heroTable.isHidden = false
        activityIndicator.stopAnimating()
        errorSV.isHidden = true
        heroTable.reloadData()
    }
    
    func onError(reason: String) {
        heroTable.isHidden = true
        activityIndicator.stopAnimating()
        errorLabel.text = reason
        errorSV.isHidden = false
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heroTable.dequeueReusableCell(withIdentifier: HeroCell.reuseIdentifier)
        
        if let cell = cell as? HeroCell {
            let hero = viewModel.heroes[indexPath.row]
            cell.setData(name: hero.name, photo: hero.photo)
        }
        
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HeroCell.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.heroes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        heroTable.deselectRow(at: indexPath, animated: true)
        
        let selectedHero = viewModel.heroes[indexPath.row]
        
        let detailView = HeroDetailBuilder().build(hero: selectedHero)
        
        navigationController?.pushViewController(detailView, animated: true)
        
        
        
    }


}
