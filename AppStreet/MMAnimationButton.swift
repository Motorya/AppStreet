//
//  MMAnimationButton.swift
//  AppStreet
//
//  Created by Марк Моторя on 01.02.17.
//  Copyright © 2017 Motorya Mark. All rights reserved.
//

import UIKit

public class MMAnimationButton: UIButton, Animatable {

    @IBInspectable open var startAnimation: Bool = false
    @IBInspectable open var nameAnimation: String = ""
    @IBInspectable open var curve: String = ""
    @IBInspectable open var force: CGFloat = 1
    @IBInspectable open var x: CGFloat = 0
    @IBInspectable open var y: CGFloat = 0
    @IBInspectable open var scaleX: CGFloat = 1
    @IBInspectable open var scaleY: CGFloat = 1
    @IBInspectable open var repeatCount: Float = 1
    @IBInspectable open var delay: CGFloat = 0
    @IBInspectable open var duration: CGFloat = 0.7
    @IBInspectable open var damping: CGFloat = 0.7
    @IBInspectable open var velosity: CGFloat = 0.7
    open var animateForm: Bool = false
    open var opacity: CGFloat = 1
    
    lazy fileprivate var anim: Animation = Animation(self)
    
    open override func didMoveToWindow() {
        super.didMoveToWindow()
        self.anim.customDidMoveToWindow()
    }
    
    open func animate() {
        self.anim.animate()
    }
}
