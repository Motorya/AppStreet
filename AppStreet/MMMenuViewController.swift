//
//  MMMenuViewController.swift
//  AppStreet
//
//  Created by Марк Моторя on 29.01.17.
//  Copyright © 2017 Motorya Mark. All rights reserved.
//

import UIKit

class MMMenuViewController: UIViewController {
    
    @IBOutlet weak var backGroundMaskView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var buttomView: UIView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var dialogView: DesignView!
    @IBOutlet weak var shareView: AnimationView!
    @IBOutlet weak var shareButton: MMAnimationButton!
    @IBOutlet weak var twitterButton: MMAnimationButton!
    @IBOutlet weak var facebookButton: MMAnimationButton!
    @IBOutlet weak var twitterLabel: MMAnimationLabel!
    @IBOutlet weak var facebookLabel: MMAnimationLabel!
    @IBOutlet weak var maskButton: UIButton!
    
    @IBOutlet weak var backgraundImageView: UIImageView!
    @IBOutlet weak var backgraundDialogImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var animator: UIDynamicAnimator!
    var attachmentBahavior: UIAttachmentBehavior!
    var snapBehavior: UISnapBehavior!
    
    @IBAction func shareButtonPress(_ sender: Any) {
        
        UIView.animate(withDuration: 0.1) { () -> Void in
            self.dialogView.frame = CGRect(x: 25, y: 89, width: 270, height: 284)
            self.userView.frame = CGRect(x: 70, y: 371, width: 180, height: 35)
        }
        
        shareView.isHidden = false
        shareView.nameAnimation = "fadeIn"
        shareView.animate()
        
        shareButton.nameAnimation = "shake"
        shareButton.animate()
        
        showMask()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.dialogView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: nil)
        
        // Get animation Button it is Poppover
        twitterButton.nameAnimation = "slideUp"
        twitterButton.delay = 0.5
        twitterButton.animate()
        
        twitterLabel.nameAnimation = "fadeIn"
        twitterLabel.delay = 0.6
        twitterLabel.animate()
        
        facebookButton.nameAnimation = "slideUp"
        facebookButton.delay = 0.7
        facebookButton.animate()
        
        facebookLabel.nameAnimation = "fadeIn"
        facebookLabel.delay = 0.8
        facebookLabel.animate()
        
        // Off button click
        shareButton.isEnabled = false
        
    }
    
    func showMask() {
        maskButton.isHidden = false
        maskButton.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            self.maskButton.alpha = 1
            }, completion: nil)
    }
    
    @IBAction func maskButtonPress(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.dialogView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.maskButton.alpha = 0
        }, completion: nil)
        
        shareView.nameAnimation = "fadeOut"
        shareView.animate()
        shareView.isHidden = false
        
        shareButton.isEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Get animation on dialog window
        
        var scaleTransform = CGAffineTransform.identity
        scaleTransform = scaleTransform.scaledBy(x: 0.5, y: 0.5)
        scaleTransform = scaleTransform.translatedBy(x: 0, y: -300)
        dialogView.transform = scaleTransform
        
        UIView.animate(withDuration: 0.5) { () -> Void in
            var scaleTransform = CGAffineTransform.identity
            scaleTransform = scaleTransform.scaledBy(x: 1, y: 1)
            scaleTransform = scaleTransform.translatedBy(x: 0, y: 0)
            self.dialogView.transform = scaleTransform
        }
        
        backgraundImageView.image = UIImage(named: data[countRecord]["image"]!)
        backgraundDialogImageView.image = UIImage(named: data[countRecord]["image"]!)
        avatarImageView.image = UIImage(named: data[countRecord]["avatar"]!)
        titleLabel.text = data[countRecord]["title"]
        
        dialogView.alpha = 1
    }
    
    var data = getData()
    var countRecord = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set Blure Effect
        addBlureEffect(view: backGroundMaskView, style: .dark)
        addBlureEffect(view: headerView, style: .dark)
        addBlureEffect(view: buttomView, style: .dark)
        
        animator = UIDynamicAnimator(referenceView: view)
        snapBehavior = UISnapBehavior(item: dialogView, snapTo: view.center)
        
        dialogView.alpha = 0
    }
    // Svayp is dialog View
    
    @IBAction func handleRecognizer(_ sender: Any) {
        
        let myView = dialogView
        let location = (sender as AnyObject).location(in: view)
        let boxLocation = (sender as AnyObject).location(in: dialogView)
        let translate = (sender as AnyObject).translation(in: view)
        
        if (sender as AnyObject).state == UIGestureRecognizerState.began {
            animator.removeBehavior(snapBehavior)
            
            let centerOffset = UIOffsetMake(boxLocation.x - (myView?.bounds)!.midX, boxLocation.y - (myView?.bounds)!.midY)
            attachmentBahavior = UIAttachmentBehavior(item: myView!, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBahavior.frequency = 0
            
            animator.addBehavior(attachmentBahavior)
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.userView.frame = CGRect(x: 69, y: 423, width: 179, height: 35)
            })
            
        } else if (sender as AnyObject).state == UIGestureRecognizerState.changed {
            attachmentBahavior.anchorPoint = location
        
        } else if (sender as AnyObject).state == UIGestureRecognizerState.ended {
            animator.removeBehavior(attachmentBahavior)
            
            snapBehavior = UISnapBehavior(item: myView!, snapTo: view.center)
            animator.addBehavior(snapBehavior)
            
            if translate.x < 300 {
                animator.removeAllBehaviors()
                
                let gravity = UIGravityBehavior(items: [dialogView])
                gravity.gravityDirection = CGVector(dx: 10, dy: 0)
                animator.addBehavior(gravity)
                
                delay(0.4){
                    self.refreshView()
                }
            }
        }
    }
    
    //MARK: Helpers Method
    
    func addBlureEffect(view: UIView, style: UIBlurEffectStyle) {
        
        view.backgroundColor = UIColor.clear
        
        let blureEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blureEffectView = UIVisualEffectView(effect: blureEffect)
        blureEffectView.frame = view.bounds
        view.insertSubview(blureEffectView, at: 0)

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
        
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
  func refreshView() {
        
        countRecord+=1
        if countRecord > 2 {
            countRecord = 0
        }
        
        animator.removeAllBehaviors()
        
        snapBehavior = UISnapBehavior(item: dialogView, snapTo: view.center)
        attachmentBahavior.anchorPoint = view.center
        
        dialogView.center = view.center
        viewDidAppear(true)
    }
}
