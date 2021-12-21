//
//  LaunchScreenView.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 21/12/21.
//

import UIKit

class LaunchScreenView: UIView{
    
    //MARK: - Components
    lazy var topImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "RickAndMortyImage")
        return image
    }()
    
    //MARK: - Initializes
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Hierarchy
    func setupHierarchy(){
        self.addSubview(topImage)
    }
    
    //MARK: - Setup Layout
    func setupLayout(){
        NSLayoutConstraint.activate([
            topImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            topImage.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            topImage.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
}
