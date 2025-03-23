import XCTest


@testable import MVVMProject



extension HeroModel {
    static let testableObject: HeroModel = dummyHero
}


final class SuccessGetSingleHeroUseCase: HeroDetailUseCaseProtocol {
    func run(hero: HeroModel, completion: @escaping (Result<HeroModel, HeroDetailError>) -> Void) {
        completion(.success(.testableObject))
    }
    
    
}

final class HeroDetailUseCaseTest: XCTestCase {
    func testWhenUseCaseSucceeded() {
        let useCase = SuccessGetSingleHeroUseCase()
        let sut = HeroDetailViewModel(useCase: useCase)
        
        let successExpectation = expectation(description: "Successful test")
        
        
        
        sut.stateMachine.bind {state in
            if state == .done {
                successExpectation.fulfill()
            }
        }
        sut.loadHero()
        
        wait(for: [successExpectation], timeout: 5)
        XCTAssertEqual(sut.hero, .testableObject)
    }
}
