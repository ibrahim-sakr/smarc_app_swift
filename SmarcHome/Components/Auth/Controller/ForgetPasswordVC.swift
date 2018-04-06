//
//  ForgetPasswordVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onRecoverPasswordClicked(_ sender: Any) {
        // send Alamofire Request to server
        // redirect to main page
    }

    @IBAction func onBackBtnClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginPage")
        
        self.present(newViewController, animated: true, completion: nil)
    }
}
