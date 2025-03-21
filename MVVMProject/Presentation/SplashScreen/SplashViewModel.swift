import Foundation

enum SplashViewStates: Equatable {
    case loading
    case done
    case error
}

final class SplashViewModel {
    
    var stateMachine = StateMachine<SplashViewStates>()
    
    func load() {
        stateMachine.update(.loading)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.stateMachine.update(.done)
        }
    }
    
}
