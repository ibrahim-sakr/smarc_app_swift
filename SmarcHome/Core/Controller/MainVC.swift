//
//  MainVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//
import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        print("Main VC Loaded");
    }

    override func viewDidAppear(_ animated: Bool) {
        // if user is LoggedIn so no need to stay here at all
        // and redirect to home page
        if AuthService.instance.isLoggedIn {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)

            let nextVC = storyBoard.instantiateViewController(withIdentifier: "HomePage")

            self.present(nextVC, animated: true, completion: nil)
        }
    }

    @IBAction func onDemoBtnClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Sorry!!", message: "the demo is Not ready yet.\nplease try to login", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func onLoginBtnClicked(_ sender: Any) {
        print("Navigating to Login Page");

        let storyBoard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "LoginPage")
        
        self.present(nextVC, animated: true, completion: nil)
    }

    @IBAction func onSettingsBtnClicked(_ sender: Any) {
        print("Navigating to Settings Page");
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
        
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "SettingsPage")
        
        self.present(nextVC, animated: true, completion: nil)
    }
}
