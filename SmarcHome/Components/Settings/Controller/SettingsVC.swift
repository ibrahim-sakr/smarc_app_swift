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
    @IBOutlet weak var socketIp: UITextField!
    @IBOutlet weak var socketPort: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onCancelBtnClicked(_ sender: Any) {
        self.redirect()
    }

    @IBAction func onSaveBtnClicked(_ sender: Any) {
        // save settings
        SettingsService.instance.serverIp = self.serverIp.text!
        SettingsService.instance.serverPort = self.serverPort.text!
        SettingsService.instance.socketIp = self.socketIp.text!
        SettingsService.instance.socketPort = self.socketPort.text!

        self.redirect()
    }
    
    func redirect() {
        if AuthService.instance.isLoggedIn {
            self.backToHomePage()
        } else {
            self.backToMainPage()
        }
    }
    
    func backToMainPage() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainPage")
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func backToHomePage() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomePage")
        self.present(newViewController, animated: true, completion: nil)
    }
}
