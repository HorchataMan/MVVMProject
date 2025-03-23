
import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SplashView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("Si se imprime este msj me corto la pinga")
    }
    //Chooses what will happen depending on the state
    func bind() {
        viewModel.stateMachine.bind { [weak self] state in
            switch state {
            case .loading: self?.loading()
            case .done: self?.doneLoading()
            case .error: self?.loadingError(reason: "Loading error")
            }
            
        }
    }

    func loading(){
        if !activityIndicator.isAnimating{
            activityIndicator.startAnimating()
        }
        
    }
    
    func doneLoading() {
        activityIndicator.stopAnimating()
        print("Done loading")
        present(LoginBuilder().build(), animated: true)
    }
    
    func loadingError(reason: String) {
        activityIndicator.stopAnimating()
        print(reason)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.load()
    }

}
