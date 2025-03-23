struct HeroDetailError: Error, Equatable {
    let errorCode: Int
    let errorHero: HeroModel
    let detail: String
    
    init(errorCode: Int, errorHero: HeroModel, detail: String) {
        self.errorCode = errorCode
        self.errorHero = errorHero
        self.detail = detail
    }
}

extension HeroDetailError {
    static func heroError(code: Int, detail: String) -> HeroDetailError {
        return HeroDetailError(errorCode: code, errorHero: dummyHero, detail: detail)
    }
}
