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
    var characterManager: CharactersManager
    
    //MARK: - Properties
    private var mainView = MainView()
    var currentPage = 1
    var isLoadingData = false
    var characterData = [CharacterData]()
    let refreshControl = UIRefreshControl()
    
    //MARK: - Initializers
    init(factory: Factory, characterManager: CharactersManager){
        self.factory = factory
        self.characterManager = characterManager
        super.init(nibName: nil, bundle: nil)
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
        refreshControl.attributedTitle = NSAttributedString(string: "Fetch Previous")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.mainView.tableView.addSubview(refreshControl)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    //MARK: - Functionality
    func loadNextPage(){
        if self.characterManager.listOfCharacters[0].info.next != nil{
            self.currentPage += 1
            loadListOfCharacters()
        } else {
            loadListOfCharacters()
        }
    }
    
    func loadPreviousPage(){
        if self.characterManager.listOfCharacters[0].info.prev != nil{
            self.currentPage -= 1
            loadListOfCharacters()
        } else {
            loadListOfCharacters()
            refreshControl.endRefreshing()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        loadPreviousPage()
        if self.characterManager.loadedData {
            refreshControl.endRefreshing()
        }
    }
    
    func loadListOfCharacters(){
        self.characterData = self.characterManager.characters
        
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global(qos: .default).async{
            self.characterManager.getNextPage(page: self.currentPage)
            self.characterManager.fetchApi()
            group.leave()
        }
        group.wait()
        
        DispatchQueue.main.async{
            self.mainView.tableView.reloadData()
            let indexPath = IndexPath(row: 0, section: 0)
            self.mainView.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            self.mainView.tableView.reloadData()
        }
        self.isLoadingData = false
    }
    
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let pos = scrollView.contentSize.height
        if (pos < scrollView.contentOffset.y + scrollView.frame.size.height){
            if !isLoadingData {
                self.isLoadingData = true
                loadNextPage()
            }
        }
    }
    
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
        return self.characterManager.characters.count
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
        cell.configureCell(character: self.characterManager.characters[indexPath.section], id: indexPath.section)
            return cell
    }
    
}

//MARK: - CharacterTableViewCellDelegate
extension ViewController: CharacterTableViewCellDelegate{
    /// toggleButton
    /// - Parameter cellId: cell Id is the row id of the clicked character
    func toggleButton(cellId: Int) {
        navigationController?.present(factory.createSelectedCharactersScene(character: self.characterManager.characters[cellId]), animated: true, completion: nil)
    }
}

extension ViewController: MainViewDelegate{
    /// Presents the Filter View Controller modally
    func filterTapped() {
        guard let navController = self.navigationController else {return}
        let viewController = factory.createFilterScene(characterManager: self.characterManager)
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
    func applyFilters(characters: CharactersManager) {
        self.characterManager = characters
        self.mainView.tableView.reloadData()
    }
    
}
