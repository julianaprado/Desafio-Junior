//
//  ViewController.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 16/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Injected Properties
    typealias Factory = SelectedCharactersSceneFactory & FilterSceneFactory
    let factory: Factory
    lazy var listOfCharacters = [CharactersData]()
    
    //MARK: - Properties
    private var mainView = MainView()
   
    //MARK: - Initializers
    init(factory: Factory, characters: [CharactersData]){
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
        self.listOfCharacters = characters

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        mainView.delegate = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.white.cgColor
    
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return listOfCharacters[0].results.count
    }
    
}

//MARK: - UITableViewDataSource

/// Disclaimer:
/// Since the table view does not permit customization of the space between cells, creating a different section for each
/// cell will bypass that.
/// **This table view has one section per character, and each section contains one row**
extension ViewController: UITableViewDataSource{
    
    /// Returns how many rows per section
    /// - Parameters:
    ///   - tableView: current table view
    ///   - section: the number of rows in each section
    /// - Returns: Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /// Creates the cell for the specified indexPath.section
    /// - Parameters:
    ///   - tableView: current table view
    ///   - indexPath: the index for the row
    /// - Returns: UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.reusableIdentifier, for: indexPath) as? CharactersTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
        cell.configureCell(character: listOfCharacters[0].results[indexPath.section], id: indexPath.section)
            return cell
    }
    
}

//MARK: - CharacterTableViewCellDelegate
extension ViewController: CharacterTableViewCellDelegate{
    /// toggleButton
    /// - Parameter cellId: cell Id is the row id of the clicked character
    func toggleButton(cellId: Int) {
        navigationController?.present(factory.createSelectedCharactersScene(character: listOfCharacters[0].results[cellId]), animated: true, completion: nil)
    }
}

extension ViewController: MainViewDelegate{
    /// Presents the Filter View Controller modally
    func filterTapped() {
        guard let navController = self.navigationController else {return}
        let viewController = factory.createFilterScene()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        viewController.delegate = self
        navController.present(viewController, animated: false)
    }

}

//MARK: - FilterViewControllerDelegate
extension ViewController: FilterViewControllerDelegate {
    /// Recieves the new list of characters with the filters applied
    /// - Parameter characters:
    /// a list of Character Data containing the characters that match the chosen filters
    func applyFilters(characters: [CharactersData]) {
        self.listOfCharacters = characters
        self.mainView.tableView.reloadData()
    }
    
}
