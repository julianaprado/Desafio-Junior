//
//  InformationStack.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 19/12/21.
//

import UIKit

/// informationType
enum informationType: String{
    case statusInfo = "Status:"
    case speciesInfo = "Species:"
    case typeInfo = "Type:"
    case genderInfo = "Gender:"
    case originInfo = "Originally From:"
}

class InformationStack: UIView {
    
    /// informationStack
    public lazy var informationStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 10
        return stack
    }()
    
    /// infoTitleLabel - (Ex: Status:, Species:, etc.)
    lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bakbakRegular(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .white
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    /// Information Label - (Ex: Alive, Human, etc.)
    lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bakbakRegular(ofSize: 18)
        label.textAlignment = .right
        label.textColor = .white
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Initializers
    init(infoType: informationType, information: String){
        super.init(frame: .zero)

        setupLabels(infoTitle: infoType.rawValue, information: information)
        
        setupHierarchy()
        setupLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Hierarchy
    func setupHierarchy(){
        informationStack.addArrangedSubview(infoTitleLabel)
        informationStack.addArrangedSubview(informationLabel)
        self.addSubview(informationStack)
    }
    
    //MARK: - Setup Layout
    func setupLayout(){
        NSLayoutConstraint.activate([
            informationStack.widthAnchor.constraint(equalTo: self.widthAnchor),
            informationStack.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
 
    }

    //MARK: - SetupLabels
    func setupLabels(infoTitle: String, information: String){
        infoTitleLabel.text = infoTitle
        informationLabel.text = information.capitalized
        if information == ""{
            informationLabel.text = " -- "
        }
    }
    
}
