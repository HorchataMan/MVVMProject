import Foundation

struct LoginError: Error {
    let reason: String
}

protocol LoginUseCaseProtocol {
    func run(username: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void)
}

final class LoginUseCase: LoginUseCaseProtocol {
    private let dataSource: SessionDataSourceProtocol
    
    init(dataSource: SessionDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func run(username: String, password: String, completion: @escaping (Result<Void, LoginError>) -> Void) {
        guard isValidUsername(username) else {
            return completion(.failure(LoginError(reason: "Invalid username")))
        }
        guard isValidPassword(password) else {
                return completion(.failure(LoginError(reason: "Invalid password")))
        }
        LoginAPIRequest(username: username, password: password)
            .perform { [weak self] response in
                switch response {
                case .success(let data):
                    self?.dataSource.storeSession(data)
                    completion(.success(()))
                case .failure:
                    completion(.failure(LoginError(reason: "Something went wrong")))
                }
            }
    }
    
    private func isValidUsername(_ string: String) -> Bool {
        !string.isEmpty && string.contains("@")
    }
    
    private func isValidPassword(_ string: String) -> Bool {
        string.count >= 4
    }
}
