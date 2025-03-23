protocol HeroDetailUseCaseProtocol {
    func run(hero: HeroModel, completion: @escaping (Result<HeroModel, HeroDetailError>) -> Void)
}

//Este codigo ya no cuenta, lo queria hacer asi pq asi es como me decia mi cerebro que lo hiciera, pero hare un remaster con usando request, pero intentare mantener lo mas posible :((


final class HeroDetailUseCase: HeroDetailUseCaseProtocol {
    
    
    func run(hero: HeroModel,
             completion: @escaping (Result<HeroModel, HeroDetailError>) -> Void) {
        if Int.random(in: 1...8) == 1{
            completion(.failure(HeroDetailError.heroError(code: 1, detail: "Its chupa-cu time")))
        } else {
            completion(.success(hero))
        }
    }
}
