//
//  FilterViewDelegate.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 19/12/21.
//

import UIKit

protocol FilterViewDelegate {
    func dismissFilterView()
    func applyFilters(filters: [[String]])
}
