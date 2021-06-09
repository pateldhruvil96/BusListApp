//
//  UIView+.swift
//  BusLists
//
//  Created by Dhruvil Rameshbhaib Patel on 09/06/21.
//

import Foundation
import UIKit

extension UIView{
    func addShadow(cornerRadius:CGFloat = 0,shadowRadius:CGFloat = 5,shadowColor:UIColor = .black,shadowOpacity:Float = 0.2,shadowOffsetHeight:Int = 0){
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOffset = CGSize(width: 0, height: shadowOffsetHeight)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
    }
}
