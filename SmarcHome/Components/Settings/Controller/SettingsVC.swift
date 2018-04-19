//
//  SettingsVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var serverIp: UITextField!
    @IBOutlet weak var serverPort: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(SettingsService.instance.serverIp)
        print(SettingsService.instance.serverPort)
    }

    @IBAction func onCancelBtnClicked(_ sender: Any) {
        // if user logged in
            // redirect to HomePage
        // if NOT
            // redirect to MainPage
        self.backToMainPage()
    }

    @IBAction func onSaveBtnClicked(_ sender: Any) {
        // save settings
        SettingsService.instance.serverIp = self.serverIp.text!
        SettingsService.instance.serverPort = self.serverPort.text!

        if AuthService.instance.isLoggedIn {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomePage")
            self.present(newViewController, animated: true, completion: nil)
        } else {
            self.backToMainPage()
        }
    }
    
    func backToMainPage() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainPage")
        self.present(newViewController, animated: true, completion: nil)
    }
}
