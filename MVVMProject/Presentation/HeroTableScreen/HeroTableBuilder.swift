import UIKit

final class HeroTableBuilder {
    func build() -> UIViewController {
        let viewModel = HeroTableViewModel()
        let viewController = HeroTableViewController(viewModel: viewModel)
        let view = UINavigationController(rootViewController: viewController)
        
        view.modalPresentationStyle = .fullScreen
        
        return view
    }
}
