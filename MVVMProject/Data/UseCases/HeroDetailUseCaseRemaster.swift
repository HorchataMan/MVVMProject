final class HeroDetailUseCaseRemaster: HeroDetailUseCaseProtocol {
    func run(
        hero: HeroModel,
        completion: @escaping (Result<HeroModel, HeroDetailError>) -> Void) {
        
            GetHeroesAPIRequest(name: hero.name).perform { result in
                do {
                    let heroArray = try result.get()
                    let mapper = HeroDTOToHeroModelMapper()
                    guard let hero = heroArray.first else {
                        completion(.success(dummyHero))
                        return
                    }
                    if Int.random(in: 1...8) == 1 {
                        completion(.success(dummyHero))
                    } else {
                        completion(.success(mapper.map(hero)))
                    }
                    
                    
                } catch {
                    completion(.failure(HeroDetailError.heroError(code: 1, detail: error.localizedDescription)))
                }
            }
    }
}
