//
//  LaunchScreenViewController.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 21/12/21.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    //MARK: - Injected Properties
    typealias Factory = MainViewSceneFactory
    let factory: Factory
    
    //MARK: - Properties
    private var mainView = LaunchScreenView()
    var loadedData = false
    var characterManager: CharactersManager
    
    //MARK: - Initializers
    init(factory: Factory){
        self.factory = factory
        self.characterManager = CharactersManager(searchFor: "character/")
        super.init(nibName: nil, bundle: nil)
        self.view = mainView
        self.characterManager.fetchApi()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ///timer to decide when the transition to the next view will occur, and to allow for the api to load
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(authorizeSegue), userInfo: nil, repeats: false)
    }
    
    //MARK: - Functionality
    @objc private func authorizeSegue() {
        if self.characterManager.loadedData {
            /// guard the navigation controller
            guard let navController = self.navigationController else {return}
            
            ///creates the fade out transition animation
            let viewController = factory.createMainViewScene(characterManager: self.characterManager)
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.navigationController?.view.layer.add(transition, forKey: nil)
            
            ///pops current viewControllar from the navigation controller stack and pushes the new View Controller
            DispatchQueue.main.async {
                self.navigationController?.popToViewController(ofClass: ViewController.self, animated: false)
                navController.pushViewController(viewController, animated: false)
            }
        }
    }
}
