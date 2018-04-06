//
//  SettingsVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onBackBtnClicked(_ sender: Any) {
        // if user logged in
        // redirect to HomePage
        // if NOT
        // redirect to MainPage
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainPage")
        
        self.present(newViewController, animated: true, completion: nil)
    }
}
