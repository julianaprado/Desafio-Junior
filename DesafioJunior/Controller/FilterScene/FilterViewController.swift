//
//  FilterViewController.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 19/12/21.
//

import UIKit

class FilterViewController: UIViewController{
    
    //MARK: - Injected Properties
    typealias Factory = MainViewSceneFactory
    let factory: Factory
    var characterManager: CharactersManager
    
    //MARK: - Properties
    private var mainView = FilterVIew()
    var delegate: FilterViewControllerDelegate?
    var filterString = ""

    
    //MARK: - Initializers
    init(factory: Factory, characterManager: CharactersManager){
        self.factory = factory
        self.characterManager = characterManager
        super.init(nibName: nil, bundle: nil)
        self.view = mainView
        self.mainView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ///since this view was presented modally, it has to be dismissed
        self.dismiss(animated: false, completion: nil)
    }
    
    //MARK: - Functionality
    /// Authorizes Segue if the api is loaded properly
    @objc private func authorizeSegue() {
        if self.characterManager.loadedData {
            ///passes the character list to the ViewController
            delegate?.applyFilters(characters: self.characterManager)
            
            ///since this view was presented modally, it has to be dismissed
            self.dismiss(animated: false, completion: nil)
        } else {
            let alert = UIAlertController(title: "Não foi possível carregar as informações.", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}

//MARK: - FilterViewDelegate
extension FilterViewController: FilterViewDelegate {
    
    /// Applies the selected filters and calls the api.
    /// - Parameter filters: a list of lists containing:
    /// filter: the filter name
    /// filter type: type of filter to apply
    func applyFilters(filters: [[String]]) {
        if filters == [] {
            DispatchQueue.main.async {
                self.navigationController?.popToViewController(ofClass: ViewController.self, animated: false)
            }
            self.dismiss(animated: false, completion: nil)
        } else {
            for filter in filters{
                print(filter)
            }
            filterString = "character/?"
            for filter in filters {
                filterString.append(filter[1].lowercased() + "=" + filter[0].lowercased())
                filterString.append("&")
            }
            filterString.removeLast(1)
            print(filterString)
            
            self.characterManager.searchFor(filters: filterString)
            self.characterManager.fetchApi()
            
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(authorizeSegue), userInfo: nil, repeats: false)
        }
    }

    /// Dismisses the Filter view
    func dismissFilterView() {
        DispatchQueue.main.async {
            self.navigationController?.popToViewController(ofClass: ViewController.self, animated: false)
        }
        self.dismiss(animated: false, completion: nil)
    }
}
