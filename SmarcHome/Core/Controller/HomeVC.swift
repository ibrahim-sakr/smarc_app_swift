//
//  HomeVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home VC Loaded");
    }
    
    @IBAction func onLightBtnClicked(_ sender: Any) {
        print("Navigating to Lights Page");

        let storyBoard: UIStoryboard = UIStoryboard(name: "Light", bundle: nil)

        let nextVC = storyBoard.instantiateViewController(withIdentifier: "LightIndex")

        self.present(nextVC, animated: true, completion: nil)
    }

    @IBAction func onUsersBtnClicked(_ sender: Any) {
        print("Navigating to Users Page");
        let storyBoard: UIStoryboard = UIStoryboard(name: "User", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "UserIndexList")
        self.present(nextVC, animated: true, completion: nil)
    }

    @IBAction func onLogoutBtmClicked(_ sender: Any) {
        print("Navigating to Main Page");
        AuthService.instance.logout();
        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "MainPage")
        self.present(nextVC, animated: true, completion: nil)
    }
}
