//
//  MMDetailViewController.swift
//  AppStreet
//
//  Created by Марк Моторя on 29.01.17.
//  Copyright © 2017 Motorya Mark. All rights reserved.
//

import UIKit

class MMDetailViewController: UIViewController {

    @IBOutlet weak var backgraundImageDetailView: UIImageView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var descriptionViewDetail: UIImageView!
    @IBOutlet weak var detaiSpecification: UITextView!
    @IBOutlet weak var detailNamePost: UILabel!
    @IBOutlet weak var detaiUserPost: UILabel!
    @IBOutlet weak var detaiUserAvatar: UIImageView!
    @IBOutlet weak var detailUserLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backgraundImageDetailView.image = UIImage(named: data[countRecord]["image"]!)
        detaiUserAvatar.image = UIImage(named: data[countRecord]["avatar"]!)
        detailUserLabel.text = data[countRecord]["title"]
        detaiUserPost.text = data[countRecord]["post"]
        detaiSpecification.text = data[countRecord]["specification"]
        
        viewDetail.alpha = 1
        
    }
    
    var data = getData()
    var countRecord = 0
    
    func refreshView() {
        
        countRecord+=1
        if countRecord > 2 {
            countRecord = 0
        }
     /*   Animation.removeAllBehaviors()
   
        snapBehavior = UISnapBehavior(item: dialogView, snapTo: view.center)
        attachmentBahavior.anchorPoint = view.center
        
        dialogView.center = view.center
        viewDidLoad(true)*/
    }
}
