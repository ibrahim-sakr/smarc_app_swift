//
//  Sidebar.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/26/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class SidebarVC: UIViewController {

    @IBOutlet weak var pageOneBtn: UIButton!
    @IBOutlet weak var pageTwoBtn: UIButton!
    @IBOutlet weak var pageThreeBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goToPageOne() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "PageOne") as! PageOneVC
        revealViewController().pushFrontViewController(controller, animated: true)
    }

    @IBAction func goToPageTwo() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "PageTwo") as! PageTwoVC
        revealViewController().pushFrontViewController(controller, animated: true)
    }

    @IBAction func goToPageThree() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "PageThree") as! PageThreeVC
        revealViewController().pushFrontViewController(controller, animated: true)
    }

}
