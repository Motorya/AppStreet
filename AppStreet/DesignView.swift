//
//  DesignView.swift
//  BasicAnimation
//
//  Created by Марк Моторя on 28.01.17.
//  Copyright © 2017 Motorya Mark. All rights reserved.
//

import UIKit

@IBDesignable open class DesignView: AnimationView {
    
    @IBInspectable open var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
