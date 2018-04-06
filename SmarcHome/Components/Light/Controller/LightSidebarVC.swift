//
//  LightSidebarVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/1/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class LightSidebarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Light Sidebar VC Loaded")
    }

    @IBAction func onHomeBtnClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomePage")
        
        self.present(newViewController, animated: true, completion: nil)
    }

    @IBAction func onUserBtnClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "User", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "UserIndex")
        
        self.present(newViewController, animated: true, completion: nil)
    }
}
