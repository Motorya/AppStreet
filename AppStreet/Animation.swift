//
//  Animation.swift
//  BasicAnimation
//
//  Created by Марк Моторя on 28.01.17.
//  Copyright © 2017 Motorya Mark. All rights reserved.
//

import UIKit

@objc public protocol Animatable {
    var startAnimation: Bool { get set }
    var nameAnimation: String { get set }
    var curve: String { get set }
    var x: CGFloat { get set }
    var y: CGFloat { get set }
    var scaleX: CGFloat { get set }
    var scaleY: CGFloat { get set }
    var force: CGFloat { get set }
    var repeatCount: Float { get set }
    var opacity: CGFloat { get set }
    var animateForm: Bool { get set }
    var duration: CGFloat { get set }
    var delay: CGFloat { get set }
    var damping: CGFloat { get set }
    var velosity: CGFloat { get set }
    
    //UIView
    var transform: CGAffineTransform { get set }
    var layer: CALayer { get }
    var alpha: CGFloat { get set }
    
    func animate()
}

open class Animation: NSObject {
    
    fileprivate unowned var view: Animatable
    fileprivate var shouldAnimateAfterActive = false
    
    init(_ view: Animatable) {
        self.view = view
        super.init()
        generalInit()
    }
    
    func generalInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(Animation.didBecomeActiveNotification(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    func didBecomeActiveNotification(_ notification: Notification) {
        if shouldAnimateAfterActive {
            animate()
            shouldAnimateAfterActive = false
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    fileprivate var startAnimation: Bool { get { return self.view.startAnimation } set { self.view.startAnimation = newValue }}
    fileprivate var nameAnimation: String { get { return self.view.nameAnimation } set { self.view.nameAnimation = newValue }}
    fileprivate var curve: String { get { return self.view.curve } set { self.view.curve = newValue }}
    fileprivate var x: CGFloat { get { return self.view.x } set { self.view.x = newValue }}
    fileprivate var y: CGFloat { get { return self.view.y } set { self.view.y = newValue }}
    fileprivate var scaleX: CGFloat { get { return view.scaleX } set { view.scaleX = newValue }}
    fileprivate var scaleY: CGFloat { get { return self.view.scaleY } set { self.view.scaleY = newValue }}
    fileprivate var force: CGFloat { get { return self.view.force } set { self.view.force = newValue }}
    fileprivate var repeatCount: Float { get { return self.view.repeatCount } set { self.view.repeatCount = newValue }}
    fileprivate var opacity: CGFloat { get { return self.view.opacity } set { self.view.opacity = newValue }}
    fileprivate var animateForm: Bool { get { return self.view.animateForm } set { self.view.animateForm = newValue }}
    fileprivate var duration: CGFloat { get { return self.view.duration } set { self.view.duration = newValue }}
    fileprivate var delay: CGFloat { get { return self.view.delay } set { self.view.delay = newValue }}
    fileprivate var velosity: CGFloat { get { return self.view.velosity } set { self.view.velosity = newValue }}
    fileprivate var damping: CGFloat { get { return self.view.damping } set { self.view.damping = newValue }}
    
    
    //UIView
    fileprivate var transform: CGAffineTransform { get { return self.view.transform } set { self.view.transform = newValue }}
    fileprivate var layer: CALayer { return view.layer }
    fileprivate var alpha: CGFloat { get { return self.view.alpha } set { self.view.alpha = newValue }}
    
    public enum AnimationPreset: String {
        case SlideLeft = "slideLeft"
        case SlideRight = "slideRight"
        case SlideUp = "slideUp"
        case FadeIn = "fadeIn"
        case FadeOut = "fadeOut"
        case ZoomIn = "zoomIn"
        case ZoomOut = "zoomOut"
        case SqueezeLeft = "squeezeLeft"
        case SqueezeRight = "squeezeRight"
        case Shake = "shake"
        case Morph = "morph"
    }
    
    public enum AnimationCurve: String {
        case EaseIn = "easeIn"
        case EaseOut = "easeOut"
        case EaseInOut = "easeInOut"
        case Linear = "linear"
        case EaseOutCirc = "easeOutCirc"
        case EaseInOutCirc = "easeInOutCirc"
    }
    
    func animatePreset() {
        alpha = 1
        if let animation = AnimationPreset(rawValue: nameAnimation) {
            switch animation {
            case .SlideLeft: x = 300 * force
            case .SlideRight: x = -300 * force
            case .SlideUp: y = 300 * force
            case .FadeIn: opacity = 0
            case .FadeOut: animateForm = false
            case .ZoomIn:
                opacity = 0
                scaleX = 2 * force
                scaleY = 2 * force
            case .ZoomOut:
                animateForm = false
                opacity = 0
                scaleX = 2 * force
                scaleY = 2 * force
            case .SqueezeLeft:
                x = 300
                scaleX = 3 * force
            case .SqueezeRight:
                x = -300
                scaleX = 3 * force
            case .Shake:
                let animation = CAKeyframeAnimation()
                animation.keyPath = "position.x"
                animation.values = [0, 5*force, -5*force, 5*force, 0]
                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                animation.timingFunction = animateCurveTimingFunction(curve)
                animation.duration = CFTimeInterval(duration)
                animation.isAdditive = true
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.add(animation, forKey: "shake")
            case .Morph:
                let morphX = CAKeyframeAnimation()
                morphX.keyPath = "transform.scale.x"
                morphX.values = [1, 1.3*force, 0.7, 1.3*force, 1]
                morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                morphX.timingFunction = animateCurveTimingFunction(curve)
                morphX.duration = CFTimeInterval(duration)
                morphX.repeatCount = repeatCount
                morphX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.add(morphX, forKey: "morphX")
                
                let morphY = CAKeyframeAnimation()
                morphY.keyPath = "transform.scale.y"
                morphY.values = [1, 0.7, 1.3*force, 0.7, 1]
                morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                morphY.timingFunction = animateCurveTimingFunction(curve)
                morphY.duration = CFTimeInterval(duration)
                morphY.repeatCount = repeatCount
                morphY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.add(morphY, forKey: "morphY")
                
            }
        }
    }
    
    func animateCurveTimingFunction(_ curve: String) -> CAMediaTimingFunction {
        if let curve = AnimationCurve(rawValue: curve) {
            switch curve {
            case .EaseIn:
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            case .EaseOut:
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            case .EaseInOut:
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            case .Linear:
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            case .EaseOutCirc:
                return CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1)
            case .EaseInOutCirc:
                return CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
            }
        }
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
    }
    
    func animationOptions(_ curve: String) -> UIViewAnimationOptions {
        if let curve = AnimationCurve(rawValue: curve) {
            switch curve {
            case .EaseIn: return UIViewAnimationOptions.curveEaseIn
            case .EaseOut: return UIViewAnimationOptions.curveEaseOut
            case .EaseInOut: return UIViewAnimationOptions()
            default: break
            }
        }
        return UIViewAnimationOptions.curveLinear
    }
    
    open func animate() {
        animateForm = true
        animatePreset()
        configureView()
    }
    
    func configureView() {
        if animateForm {
            let translate = CGAffineTransform(translationX: self.x, y: self.y)
            let scale = CGAffineTransform(scaleX: self.scaleX, y: self.scaleY)
            self.transform = translate.concatenating(scale)
            
            self.alpha = self.opacity
        }
        
        UIView.animate(withDuration: TimeInterval(duration),
            delay: TimeInterval(delay),
            usingSpringWithDamping: damping,
            initialSpringVelocity: velosity,
            options: animationOptions(curve),
            animations: { [weak self] in
            if let _self = self {
                if _self.animateForm {
                    _self.transform = CGAffineTransform.identity
                    _self.alpha = 1
                } else {
                    let translate = CGAffineTransform(translationX: _self.x, y: _self.y)
                    let scale = CGAffineTransform(scaleX: _self.scaleX, y: _self.scaleY)
                    _self.transform = translate.concatenating(scale)
                    
                    _self.alpha = _self.opacity
                }
            }
            
            }, completion: { [weak self] finished in
                self?.resetAll()
            })
    }
    
    func resetAll() {
        x = 0
        y = 0
        nameAnimation = ""
        damping = 0.7
        velosity = 0.7
        delay = 0
        duration = 0.7
        repeatCount = 1
    }
    
    open func customDidMoveToWindow() {
        if startAnimation {
            if UIApplication.shared.applicationState != .active {
                shouldAnimateAfterActive = true
                return
            }
            alpha = 0
            animate()
        }
    }

}
