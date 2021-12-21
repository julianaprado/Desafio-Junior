//
//  CharactersTableViewCell.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 16/12/21.
//

import UIKit

class CharactersTableViewCell: UITableViewCell{
    
    //MARK: - Properties
    static let reusableIdentifier = "CharactersTableViewCell"
    var delegate: CharacterTableViewCellDelegate?
    var id = -1
    
    //MARK: - Components
    
    //Character name Label
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.sizeToFit()
        label.font = .bakbakRegular(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //Character name rectangular view
    lazy var nameContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rickGreen
        view.layer.masksToBounds = true
        return view
    }()
    
    //Character image
    lazy var charImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //"Check Target" Button
    public var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.backgroundColor = .rickGreen
        button.layer.masksToBounds = true
        button.setTitle("Check Target", for: .normal)
        button.titleLabel?.font = .bakbakRegular(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(toggleCharacter), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CharactersTableViewCell.reusableIdentifier)
        setupHierarchy()
        self.backgroundColor = .secondaryBackground
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Hierarchy
    func setupHierarchy(){
        nameContainer.addSubview(name)
        contentView.addSubview(nameContainer)
        contentView.addSubview(charImage)
        contentView.addSubview(button)
    }
    
    //MARK: - LayoutSubviews
    override func layoutSubviews() {
        
        charImage.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            //Character image constraints
            charImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            charImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            charImage.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            charImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            charImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            //Character name container constraints
            nameContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.14),
            nameContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            //Character name constraints
            name.centerXAnchor.constraint(equalTo: nameContainer.centerXAnchor),
            name.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor,constant: 10),
            name.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor, constant: -10),
            name.heightAnchor.constraint(equalTo: nameContainer.heightAnchor),
            
            //Button constraints
            button.topAnchor.constraint(equalTo: charImage.bottomAnchor, constant: 10),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            button.widthAnchor.constraint(equalTo: charImage.widthAnchor),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
    }
    
    //MARK: - Configuration
    public func configureCell(character: CharacterData, id: Int){
        self.id = id
        if let url = character.image {
            if let urlPhoto = URL(string: url) {
                do {
                    let data = try Data(contentsOf: urlPhoto)
                    let image = UIImage(data: data)
                    charImage.image = image
                } catch _ {
                }
            }
            
            if character.status == "Dead" {
                button.backgroundColor = .rickRed
                button.setTitle("Check Specifics", for: .normal)
                nameContainer.backgroundColor = .rickRed
                name.text = "Eliminated: "+character.name
            } else {
                name.text = character.name
                button.backgroundColor = .rickGreen
                button.setTitle("Check Target", for: .normal)
                nameContainer.backgroundColor = .rickGreen
            }
        }
    }
    
    //MARK: - Functionality
    @objc func toggleCharacter(sender: UIButton){
        delegate?.toggleButton(cellId: self.id)
        sender.backgroundColor = .rickOrange
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if self.nameContainer.backgroundColor == .rickRed {
                sender.backgroundColor = .rickRed
            } else {
                sender.backgroundColor = .rickGreen
            }
        }
    }
}
