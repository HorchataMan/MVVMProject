import Foundation

enum HeroTableViewStates: Equatable {
    case loading
    case done
    case error(reason: String)
}

final class HeroTableViewModel {
    let useCase: GetHeroesUseCaseProtocol
    let stateMachine = StateMachine<HeroTableViewStates>()
    private(set) var heroes: [HeroModel] = []
    
    init(useCase: GetHeroesUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func getHeroes() {
        stateMachine.update(.loading)
        useCase.run {
            [weak self] result in
            
            switch result {
            case .success(let heroes):
                self?.heroes = heroes
                self?.stateMachine.update(.done)
            case .failure(let error):
                print(error.localizedDescription)
                self?.stateMachine.update(.error(reason: "Couldn't fetch data"))
            }
        }
    }
}
