import XCTest

@testable import MVVMProject


extension HeroModel {
    static let dummyObject = HeroModel(identifier: "1",
                                       name: "Test",
                                       description: "Test",
                                       photo: "Test",
                                       favorite: false)
}

private final class SuccessGetHeroesUseCase: GetHeroesUseCaseProtocol {
    func run(completion: @escaping (Result<[HeroModel], any Error>) -> Void) {
        completion(.success([.dummyObject]))
    }
}

final class HeroesListViewModelTests: XCTestCase {
    func testWhenUseCaseSucceedsStateIsSuccess() {
        let useCase = SuccessGetHeroesUseCase()
        let sut = HeroTableViewModel(useCase: useCase)
        
        let successExpectation = expectation(description: "Success scenario")
        sut.stateMachine.bind { state in
            if state == .done {
                successExpectation.fulfill()
            }
        }
        
        sut.getHeroes()
        wait(for: [successExpectation], timeout: 3)
        XCTAssertEqual(sut.heroes, [.dummyObject])
    }
}
