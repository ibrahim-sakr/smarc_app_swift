//
//  HomeVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home VC Loaded");
    }
    
    @IBAction func onLightBtnClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Light", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "LightIndex")
        self.present(nextVC, animated: true, completion: nil)
    }

    @IBAction func onUsersBtnClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "User", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "UserIndexList")
        self.present(nextVC, animated: true, completion: nil)
    }

    @IBAction func onLogoutBtmClicked(_ sender: Any) {
        AuthService.instance.logout();

        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "MainPage")
        self.present(nextVC, animated: true, completion: nil)
    }

}
