import Foundation

enum LoginViewState: Equatable {
    case loading
    case success
    case error(reason: String)
}

final class LoginViewModel {
    let stateMachine = StateMachine<LoginViewState>()
    let useCase: LoginUseCaseProtocol
    
    init(useCase: LoginUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func login(email: String?, password: String?) {
        stateMachine.update(.loading)
        useCase.run(username: email ?? "", password: password ?? "") {
            [weak self] result in
            switch result {
            case .success: self?.stateMachine.update(.success)
            case .failure(let error):
                self?.stateMachine.update(.error(reason: error.reason))
            }
            
        }
    }
    
}
