

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("Boooooom!!!!")
    }
    
    func bind() {
        viewModel.stateMachine.bind {
            [weak self] result in
            switch result {
            case .loading: self?.onLoading()
            case .success: self?.onSuccess()
            case .error(let reason): self?.onError(reason: reason)
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        viewModel.login(email: emailTF.text, password: passwordTF.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func onLoading(){
        activityIndicator.startAnimating()
        loginButton.isHidden = true
        errorLabel.isHidden = true
        
    }
    
    func onSuccess() {
        activityIndicator.stopAnimating()
        loginButton.isHidden = false
        errorLabel.isHidden = true
        print("yay signed in correctly")
        
    }
    
    func onError(reason: String) {
        errorLabel.text = reason
        errorLabel.isHidden = false
        activityIndicator.stopAnimating()
        loginButton.isHidden = false
        
    }

}
