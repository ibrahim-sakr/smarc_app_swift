//
//  PageThreeVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/26/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class PageThreeVC: UIViewController {

    @IBOutlet weak var sidebarBtn: UIButton!
    @IBOutlet weak var pageOneBtn: UIButton!
    @IBOutlet weak var pageTwoBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sidebarBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    }

    @IBAction func goToPageOne() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "PageOne") as! PageOneVC
        revealViewController().setFront(controller, animated: true)    }

    @IBAction func goToPageTwo() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "PageTwo") as! PageTwoVC
        revealViewController().setFront(controller, animated: true)    }

}
