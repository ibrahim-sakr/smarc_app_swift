//
//  ForgetPasswordVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.isHidden = true;
        spinner.stopAnimating();
    }

    @IBAction func onRecoverPasswordClicked(_ sender: Any) {
        self.spinner.startAnimating();
        self.spinner.isHidden = false;

        // send Alamofire Request to server
        // redirect to main page
    }

    @IBAction func onBackBtnClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: AuthConst.STORYBOARD_ID, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: AuthConst.LOGIN_PAGE_ID)
        self.present(newViewController, animated: true, completion: nil)
    }
}
