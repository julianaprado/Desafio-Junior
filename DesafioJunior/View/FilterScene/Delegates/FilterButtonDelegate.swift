//
//  FilterButtonDelegate.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 19/12/21.
//

import Foundation

protocol FilterButtonDelegate {
    func filterOption(filterToApply filter: String, removeFilter: Bool, filterType: String)
}
