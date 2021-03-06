//
//  AppContainer.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 16/12/21.
//

import UIKit

class AppContainer{
    /// The Main Navigation Controller with the root set in MainViewController
    lazy var navigationController = MainNavigationController(rootViewController: self.createLaunchScreenViewScene())
 
}

//MARK: - NavigationController
protocol NavigationControllerFactory {
    /// Creates an instance of NavigationController to be used
    /// - Returns: An instance of NavigationController
    func createNavigationController() -> MainNavigationController
}

extension AppContainer: NavigationControllerFactory {
    
    func createNavigationController() -> MainNavigationController {
        return navigationController
    }

}

//MARK: - LaunchScreenViewController
protocol LaunchScreenViewSceneFactory {
    /// Creates an instance of the ViewController to be used
    /// - Returns: ViewController
    func createLaunchScreenViewScene() -> LaunchScreenViewController
}

extension AppContainer: LaunchScreenViewSceneFactory {
    
    func createLaunchScreenViewScene() -> LaunchScreenViewController {
        return LaunchScreenViewController(factory: self)
    }
}

//MARK: - MainViewController
protocol MainViewSceneFactory {
    /// Creates an instance of the ViewController to be used
    /// - Returns: ViewController
    func createMainViewScene(characterManager: CharactersManager) -> ViewController
}

extension AppContainer: MainViewSceneFactory {
    func createMainViewScene(characterManager: CharactersManager) -> ViewController {
        return ViewController(factory: self, characterManager: characterManager)
    }
}

//MARK: - MainViewController
protocol SelectedCharactersSceneFactory {
    /// Creates an instance of the SelectedCharacterViewController to be used
    /// - Returns: SelectedCharacterViewController
    func createSelectedCharactersScene(character: CharacterData) -> SelectedCharacterViewController
}

extension AppContainer: SelectedCharactersSceneFactory {
    
    func createSelectedCharactersScene(character: CharacterData) -> SelectedCharacterViewController {
        return SelectedCharacterViewController(character: character)
    }
    
}

//MARK: - FilterViewController
protocol FilterSceneFactory {
    /// Creates an instance of the FilterViewController to be used
    /// - Returns: FilterViewController
    func createFilterScene(characterManager: CharactersManager) -> FilterViewController
}

extension AppContainer: FilterSceneFactory {
    
    func createFilterScene(characterManager: CharactersManager) -> FilterViewController {
        return FilterViewController(factory: self, characterManager: characterManager)
    }
    
}
