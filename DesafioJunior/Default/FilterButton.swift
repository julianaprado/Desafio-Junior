//
//  FilterButton.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 19/12/21.
//

import UIKit

class FilterButton: UIView {
    
    //MARK: - Properties
    var delegate: FilterButtonDelegate?
    var buttonPressed = false
    var lastPressed = false
    
    //MARK: - Injected Properties
    var type = ""
    var label: String?
    
    //MARK: - Components
    lazy var button: UIButton = {
        let but = UIButton()
        but.titleLabel?.font = .bakbakRegular(ofSize: 15)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.clipsToBounds = true
        but.layer.cornerRadius = 5
        but.backgroundColor = .rickGreen
        but.layer.masksToBounds = true
        but.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return but
    }()
    
    //MARK: - Initializers
    init(filterLabel: String, filterType: String){
        self.label = filterLabel
        self.type = filterType
        super.init(frame: .zero)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Hierarchy
    func setupHierarchy(){
        button.setTitle(self.label, for: .normal)
        self.addSubview(button)
    }
    
    //MARK: - Setup Layout
    func setupLayout(){
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: self.widthAnchor),
            button.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
    
    //MARK: - Functionality
    @objc func buttonTapped(){
        buttonPressed = true
        if buttonPressed != lastPressed {
            button.backgroundColor = .rickOrange
            lastPressed = buttonPressed
            if let label = label {
                delegate?.filterOption(filterToApply: label, removeFilter: false, filterType: self.type)
            }
        } else {
            button.backgroundColor = .rickGreen
            lastPressed = !buttonPressed
            if let label = label {
                delegate?.filterOption(filterToApply: label, removeFilter: true, filterType: self.type)
            }
        }
    }
}
