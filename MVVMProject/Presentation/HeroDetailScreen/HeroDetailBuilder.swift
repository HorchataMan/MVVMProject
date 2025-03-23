import UIKit

final class HeroDetailBuilder {
    func build(hero: HeroModel) -> UIViewController {
        let useCase = HeroDetailUseCaseRemaster()
        let viewModel = HeroDetailViewModel(useCase: useCase)
        viewModel.hero = hero
        let viewController = HeroDetailViewController(viewModel: viewModel)
        
        
        return viewController
    }
}
