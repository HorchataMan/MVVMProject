

import UIKit

class HeroDetailViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var heroImage: AsyncImage!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroSV: UIStackView!
    
    private let viewModel: HeroDetailViewModel
    
    init(viewModel: HeroDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HeroDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("Hello darkness my old friend")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        heroImage.clipsToBounds = true
        heroImage.layer.cornerRadius = heroImage.frame.height/2
        bind()
        viewModel.loadHero()
    }
    
    func bind() {
        viewModel.stateMachine.bind { [weak self] state in
            switch state {
            case .loading: self?.onLoading()
            case .done: self?.onDone()
            case .error(let reason): self?.onError(reason: reason)
            }
            
        }
    }
    
    func onLoading(){
        heroSV.isHidden = true
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        print("loading")
    }
    
    func onDone() {
        heroName.text = viewModel.hero.name
        errorLabel.isHidden = true
        heroDescription.text = viewModel.hero.description
        heroImage.setImage(viewModel.hero.photo)
        heroSV.isHidden = false
        activityIndicator.stopAnimating()
        print("Done loading details")
    }
    
    func onError(reason: String) {
        heroName.text = viewModel.hero.name
        heroDescription.text = viewModel.hero.description
        heroImage.setImage(viewModel.hero.photo)
        heroSV.isHidden = true
        errorLabel.text = reason
        errorLabel.isHidden = false
        activityIndicator.stopAnimating()
        print(reason)
    }
   
}
