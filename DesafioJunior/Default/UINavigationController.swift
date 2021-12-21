//
//  UINavigationController.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 21/12/21.
//

import Foundation
import UIKit

///Extension to allow to pop to a given ViewController
extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
      if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
        popToViewController(vc, animated: animated)
      }
    }
}
