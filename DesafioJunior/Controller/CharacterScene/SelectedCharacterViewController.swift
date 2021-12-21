//
//  SelectedCharacterViewController.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 18/12/21.
//

import UIKit

class SelectedCharacterViewController: UIViewController {
    
    //MARK: - Injected Properties
    var character: CharacterData?
    
    //MARK: - Properties
    let mainView = SelectedCharacterView()
    
    //MARK: - Initializers
    init(character: CharacterData){
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        if let char = character {
            mainView.setupCharacterInfo(character: char)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ///since this view was presented modally, it has to be dismissed
        dismiss(animated: false, completion: nil)
    }
    
 }
