import Foundation

enum HeroDetailState: Equatable {
    case loading
    case done
    case error(reason: String)
}

final class HeroDetailViewModel {
    var hero: HeroModel = dummyHero
    let stateMachine = StateMachine<HeroDetailState>()
    let useCase: HeroDetailUseCaseProtocol
    
    init(useCase: HeroDetailUseCaseProtocol) {
        
        self.useCase = useCase
    }
    
    func loadHero() {
        stateMachine.update(.loading)
        useCase.run(hero: self.hero) { [weak self] result in
            
            switch result {
            case .success(let hero):
                print(hero.name)
                self?.hero = hero
                self?.stateMachine.update(.done)
            case .failure(let error):
                self?.hero = error.errorHero
                self?.stateMachine.update(.error(reason: "Unexpected error"))
                
            }
            
        }
    }
    
}
