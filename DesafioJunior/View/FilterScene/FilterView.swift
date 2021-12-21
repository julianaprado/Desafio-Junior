//
//  FilterView.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 19/12/21.
//

import UIKit

class FilterVIew: UIView{
    
    //MARK: - Properties
    var delegate: FilterViewDelegate?
    var filters = [[String]]()
    
    //MARK: - Components
    /// Entire View
    fileprivate let container: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    
    /// Stack that contains all the filters
    lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 15
        return stack
    }()
    
    /// "Filter" title
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bakbakRegular(ofSize: 30)
        label.text = "Filter Characters"
        label.textColor = .white
        label.sizeToFit()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    ///Close Icon
    lazy var closeIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "xmark.circle.fill")
        image.tintColor = .white
        return image
    }()
    
    ///Stack that contains the 'Status' Filter Buttons and Ttitle
    lazy var statusFilterStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 15
        return stack
    }()
    
    ///Title 'Status' for the status Filter buttons
    lazy var statusTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bakbakRegular(ofSize: 20)
        label.text = "Status"
        label.textColor = .white
        return label
    }()
    
    ///Stack that contains the 'Gender' Filter Buttons and Ttitle
    lazy var genderFilterStack1: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 15
        return stack
    }()
    
    ///Stack that contains the 'Gender' Filter Buttons and Ttitle
    lazy var genderFilterStack2: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 15
        return stack
    }()
    
    ///Title 'Gender' for the gender Filter Buttons
    lazy var genderTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bakbakRegular(ofSize: 20)
        label.text = "Gender"
        label.textColor = .white
        return label
    }()
    
    ///Button to apply the filters
    public var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.backgroundColor = .rickGreen
        button.layer.masksToBounds = true
        button.setTitle("Apply Filters", for: .normal)
        button.titleLabel?.font = .bakbakRegular(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
        return button
    }()

    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTransparentBackground()
    
        setupHierarchy()
        setupLayout()
              
        let tap = UITapGestureRecognizer(target: self, action: #selector(animateOut))
        closeIcon.isUserInteractionEnabled = true
        closeIcon.addGestureRecognizer(tap)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Hierarchy
    func setupHierarchy(){
        
        container.addSubview(title)
        container.addSubview(closeIcon)
        
        ///Status Filter
        addStatusFilters()
        
        ///Gender Filter
        addGenderFilters()
        
        ///Stack that contains all the filters inside the Container View
        addFiltersToContainerStack()
        
        self.addSubview(container)
        self.addSubview(button)
    }
    
    
    /// Status filters: "Alive", "Dead" and "Unknown" added to a stack
    func addStatusFilters(){
        let aliveButton = createButton(buttonTitle: "Alive", filterType: "status")
        let deadButton = createButton(buttonTitle: "Dead", filterType: "status")
        let unknownButton = createButton(buttonTitle: "Unknown", filterType: "status")
        
        statusFilterStack.addArrangedSubview(aliveButton)
        statusFilterStack.addArrangedSubview(deadButton)
        statusFilterStack.addArrangedSubview(unknownButton)
        
    }
    
    /// Status filters: "Female", "Male", "Genderless" and "Unknown" added to a stack
    func addGenderFilters(){
        let femaleButton = createButton(buttonTitle: "Female", filterType: "gender")
        let maleButton = createButton(buttonTitle: "Male", filterType: "gender")
        let genderlessButton = createButton(buttonTitle: "Genderless", filterType: "gender")
        let unknownButton = createButton(buttonTitle: "Unknown", filterType: "gender")

        genderFilterStack1.addArrangedSubview(femaleButton)
        genderFilterStack1.addArrangedSubview(maleButton)
        genderFilterStack2.addArrangedSubview(genderlessButton)
        genderFilterStack2.addArrangedSubview(unknownButton)
    }
    
    /// All the filters added to a stack
    func addFiltersToContainerStack(){
        containerStack.addArrangedSubview(statusTitle)
        containerStack.addArrangedSubview(statusFilterStack)
        
        containerStack.addArrangedSubview(genderTitle)
        containerStack.addArrangedSubview(genderFilterStack1)
        containerStack.addArrangedSubview(genderFilterStack2)
        
        container.addSubview(containerStack)
    }
    
    //MARK: - Setup Layout
    func setupLayout(){
        NSLayoutConstraint.activate([
            
            //Entire View that contains the components of the Filter View
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            container.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            //Title Constrains
            title.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            title.rightAnchor.constraint(equalTo: closeIcon.leftAnchor),
            title.leftAnchor.constraint(equalTo: container.leftAnchor),
            
            //Stack that has both the status filters and the gender filters
            containerStack.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 20),
            containerStack.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -20),
            containerStack.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            //Status Stack Constrains
            statusFilterStack.widthAnchor.constraint(equalTo: containerStack.widthAnchor),
            
            //Gender Stack Constrains
            genderFilterStack1.widthAnchor.constraint(equalTo: containerStack.widthAnchor),
            genderFilterStack2.widthAnchor.constraint(equalTo: containerStack.widthAnchor),
            
            //Close button constrains
            closeIcon.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            closeIcon.widthAnchor.constraint(equalToConstant: 20),
            closeIcon.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -20),
            
            //Button Constrains
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: containerStack.centerXAnchor),
            button.leftAnchor.constraint(equalTo: containerStack.leftAnchor),
            button.rightAnchor.constraint(equalTo: containerStack.rightAnchor),
        ])
    }
    
    
    /// Adds the tranparent background to the view
    func addTransparentBackground(){
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundColor = .clear

            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)

            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            self.addSubview(blurEffectView)
        } else {
            self.backgroundColor = .black
        }

        self.frame = UIScreen.main.bounds
    }
    
    
    /// Creates the button for the filter options
    /// - Parameters:
    ///   - buttonTitle: The label to be visible on the button.
    ///   - filterType: The type of the filter to be stored
    /// - Returns: FilterButton
    func createButton(buttonTitle: String, filterType: String) -> FilterButton{
        let button = FilterButton(filterLabel: buttonTitle, filterType: filterType)
        button.delegate = self
        return button
    }
    
    //MARK: - Functionality
    
    /// If button to dismiss is pressed, dismiss view
    @objc fileprivate func animateOut() {
        delegate?.dismissFilterView()
    }
    
    /// if the button to apply filter is pressed, apply filter
    @objc func applyFilters(){
        delegate?.applyFilters(filters: filters)
    }
    
}

//MARK: - FilterButtonDelegate
extension FilterVIew: FilterButtonDelegate {
    /// Adds the filter label and type to an Array, or removes it if the filter is deselected
    /// - Parameters:
    ///   - filter: The filter label string
    ///   - removeFilter: A boolean to check if the user is deselecting said filter
    ///   - filterType: The type of that filter
    func filterOption(filterToApply filter: String, removeFilter: Bool, filterType: String) {
        if removeFilter {
            if let index = filters.firstIndex(of: [filter,filterType]) {
                filters.remove(at: index)
            }
        } else {
            filters.append([filter,filterType])
        }
    }
}
