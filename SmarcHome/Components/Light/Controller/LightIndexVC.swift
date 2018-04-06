//
//  LightIndexVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/1/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class LightIndexVC: UIViewController {
    
    @IBOutlet weak var lightMenuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Light VC Loaded")

        self.lightMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer());
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer());
    }

}
