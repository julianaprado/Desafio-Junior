//
//  SelectedCharacterView.swift.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 17/12/21.
//

import UIKit

class SelectedCharacterView: UIView {
    
    //MARK: - Properties
    var statusInfo = ""
    var speciesInfo = ""
    var typeInfo = ""
    var genderInfo = ""
    var originInfo = ""
    
    ///Scroll View to allow for scrolling
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    //MARK: - Components
    //Character Name
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.sizeToFit()
        label.font = .bakbakRegular(ofSize: 35)
        label.numberOfLines = 0
        return label
    }()
    
    //Character Image
    lazy var charImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //Line Divider
    lazy var divider: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
        div.clipsToBounds = true
        div.backgroundColor = .white
        return div
    }()
    
    //Stack that holds all the character's details:
    /// species - InformationStack
    /// status - InformationStack
    /// type - InformationStack
    /// gender - InformationStack
    /// origin - InformationStack
    lazy var characterDetailsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()
    
    //Location Components
    ///Container that has the Location Image, Location Title, and Character's Location Label
    lazy var locationContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .rickOrange
        return view
    }()
    
    ///Location Image
    lazy var locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "scope")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .rickRed
        return imageView
    }()
    
    ///Location Title Label
    lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.sizeToFit()
        label.textAlignment = .center
        label.font = .bakbakRegular(ofSize: 18)
        label.text = "Last Known Location:"
        label.numberOfLines = 0
        return label
    }()
    
    ///Character Location Label
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.font = .bakbakRegular(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .rickRed
        return label
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondaryBackground
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Hierarchy
    func setupHierarchy(){
        self.addSubview(scrollView)
        scrollView.addSubview(name)
        scrollView.addSubview(charImage)
        scrollView.addSubview(divider)
        
        scrollView.addSubview(characterDetailsStack)
        
        setupLocationContainer()
        
        scrollView.addSubview(locationContainer)
    }
    
    
    /// Adds the components to the Character Location Container
    func setupLocationContainer(){
        locationContainer.addSubview(locationImage)
        locationContainer.addSubview(locationTitleLabel)
        locationContainer.addSubview(locationLabel)
    }
    
    
    /// Character Details setup
    func setupCharacterDetails(){
        let status = InformationStack(infoType: .statusInfo, information: self.statusInfo)
        let species = InformationStack(infoType: .speciesInfo, information: self.speciesInfo)
        let type = InformationStack(infoType: .typeInfo, information: self.typeInfo)
        let gender = InformationStack(infoType: .genderInfo, information: self.genderInfo)
        let origin = InformationStack(infoType: .originInfo, information: self.originInfo)
        
        characterDetailsStack.addArrangedSubview(status)
        characterDetailsStack.addArrangedSubview(species)
        characterDetailsStack.addArrangedSubview(type)
        characterDetailsStack.addArrangedSubview(gender)
        characterDetailsStack.addArrangedSubview(origin)
    
    }
    
    //MARK: - Setup Layout
    func setupLayout(){
        
        charImage.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            //Scroll View constraints
            scrollView.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            
            //Character Image constraints
            charImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            charImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            charImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            charImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            //Character Name constraints
            name.topAnchor.constraint(equalTo: charImage.bottomAnchor, constant: 20),
            name.leftAnchor.constraint(equalTo: charImage.leftAnchor),
            name.rightAnchor.constraint(equalTo: charImage.rightAnchor),
            
            //Divider Constraints
            divider.heightAnchor.constraint(equalToConstant: 0.5),
            divider.widthAnchor.constraint(equalTo: charImage.widthAnchor),
            divider.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 2),
            divider.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            //Stack with the character details constraints
            characterDetailsStack.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20),
            characterDetailsStack.leftAnchor.constraint(equalTo: divider.leftAnchor),
            characterDetailsStack.rightAnchor.constraint(equalTo: divider.rightAnchor),
            characterDetailsStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
        ])
        
        //Character Location Constraints
        setupCharacterLocationConstraints()
    }
    
    func setupCharacterLocationConstraints(){
        NSLayoutConstraint.activate([
            //Container for the Location information constraints
            locationContainer.topAnchor.constraint(equalTo: characterDetailsStack.bottomAnchor, constant: 20),
            locationContainer.leftAnchor.constraint(equalTo: divider.leftAnchor),
            locationContainer.rightAnchor.constraint(equalTo: divider.rightAnchor),
            locationContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.16),
            locationContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            //Location Icon constraints
            locationImage.leftAnchor.constraint(equalTo: locationContainer.leftAnchor, constant: 10),
            locationImage.topAnchor.constraint(equalTo: locationContainer.topAnchor),
            locationImage.widthAnchor.constraint(equalTo: locationContainer.widthAnchor, multiplier: 0.2),
            locationImage.centerYAnchor.constraint(equalTo: locationContainer.centerYAnchor),
            
            //Location title constraints
            locationTitleLabel.leftAnchor.constraint(equalTo: locationImage.rightAnchor),
            locationTitleLabel.rightAnchor.constraint(equalTo: locationContainer.rightAnchor, constant: -10),
            locationTitleLabel.topAnchor.constraint(equalTo: locationContainer.topAnchor, constant: 10),
            
            //Location label constraints
            locationLabel.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor),
            locationLabel.leftAnchor.constraint(equalTo: locationImage.rightAnchor),
            locationLabel.rightAnchor.constraint(equalTo: locationContainer.rightAnchor, constant: -5),
            locationLabel.bottomAnchor.constraint(equalTo: locationContainer.bottomAnchor, constant: -20),
        ])
    }
    
    //MARK: - Configuration
    
    /// Sets the information of the specific character
    /// - Parameter character: Character Data
    public func setupCharacterInfo(character: CharacterData) {
        name.text = character.name
        
        statusInfo.append(character.status)
        speciesInfo.append(character.species)
        typeInfo.append(character.type)
        genderInfo.append(character.gender)
        originInfo.append(character.origin.name)
        locationLabel.text = character.location.name
        
        if let url = character.image {
            if let urlPhoto = URL(string: url) {
                do {
                    let data = try Data(contentsOf: urlPhoto)
                    let image = UIImage(data: data)
                    charImage.image = image
                } catch _ {
                }
            }
        }

        setupCharacterDetails()
    }
}
