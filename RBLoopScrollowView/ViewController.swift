//
//  ViewController.swift
//  RBLoopScrollowView
//
//  Created by LinkRober on 21/08/2017.
//  Copyright © 2017 LinkRober. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ratio:CGFloat = 376/400.0
        let loopScrollowView = RBLoopScrollowView.init(images: ["yep1","yep2","yep3"], imageType: .RBLocal, frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width/ratio - 60))
        view.addSubview(loopScrollowView)
        
    }



}

