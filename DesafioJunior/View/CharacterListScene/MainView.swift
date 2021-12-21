//
//  MainView.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 16/12/21.
//

import UIKit

class MainView: UIView{
    //MARK: - Properties
    var delegate: MainViewDelegate?
    
    //MARK: - Components
    //tableView
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        
        table.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.reusableIdentifier)
        
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    /// The image at the top
    lazy var topImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "RickAndMortyImage")
        return image
    }()
    
    /// The rectangular view containing the title
    lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rickOrange
        return view
    }()
    
    // 'List of Bounties' title
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "List of Bounties"
        label.font = .bakbakRegular(ofSize: 20.0)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    /// Filter icon
    lazy var filterIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "slider.horizontal.3")
        image.tintColor = .white
        return image
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(filterIconTapped(_:)))
        filterIcon.isUserInteractionEnabled = true
        filterIcon.addGestureRecognizer(tap)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Hierarchy
    func setupHierarchy(){
        self.addSubview(tableView)
        
        titleView.addSubview(title)
        titleView.addSubview(filterIcon)
        self.addSubview(titleView)
        
        self.addSubview(topImage)
    }
    
    //MARK: - Initializer
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            //Top image constraints
            topImage.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            topImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            topImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            topImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            
            //titleView constraints
            titleView.topAnchor.constraint(equalTo: topImage.bottomAnchor),
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            titleView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            //filterIcon constraints
            filterIcon.widthAnchor.constraint(equalToConstant: 27),
            filterIcon.heightAnchor.constraint(equalToConstant: 25),
            filterIcon.rightAnchor.constraint(equalTo: titleView.rightAnchor, constant: -30),
            filterIcon.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            
            //title constraints
            title.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
             
            //tableView constraints
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -20),
        ])
    
    }
    
    //MARK: - Functionality
    
    /// Filter Icon Tapped Gesture
    /// - Parameter gesture: Tap Gesture Recognizer
    @objc func filterIconTapped(_ gesture:UITapGestureRecognizer){
        //calls delegate if filter icon is tapped
        delegate?.filterTapped()
    }
    
}
