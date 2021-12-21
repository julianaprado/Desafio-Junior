//
//  Fonts.swift
//  DesafioJunior
//
//  Created by Juliana Prado on 17/12/21.
//

import UIKit

extension UIFont {
    
    //MARK: - Fonts
    class func bakbakRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "BakbakOne-Regular", size: size) ?? UIFont.systemFont(ofSize: 15)
    }
}
