import UIKit

final class HeroTableBuilder {
    func build() -> UIViewController {
        let useCase = GetHeroesUseCase()
        let viewModel = HeroTableViewModel(useCase: useCase)
        let viewController = HeroTableViewController(viewModel: viewModel)
        let view = UINavigationController(rootViewController: viewController)
        view.navigationBar.tintColor = .slateBlue
        
        view.modalPresentationStyle = .fullScreen
        
        return view
    }
}
