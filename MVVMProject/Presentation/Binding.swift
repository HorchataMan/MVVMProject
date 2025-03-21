//I know this is a binding, however, my mind understands it more as a state machine,
//so I will gaslight myself into calling it that.

import Foundation

final class StateMachine<T: Equatable> {
    typealias Completion = (T) -> Void
    
    private var completion: Completion?
    
    //This will depend on what you want to do with the different states when they are updated
    func bind(completion: @escaping Completion) {
        self.completion = completion
    }
    
    func update(_ state: T) {
        if Thread.current.isMainThread {
            completion?(state)
        } else {
            DispatchQueue.main.async {
                self.completion?(state)
            }
        }
    }
}
