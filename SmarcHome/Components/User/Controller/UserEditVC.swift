//
//  UserEditVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/5/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class UserEditVC: UIViewController {
    
    // the current selected user
    var user: User!

    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.user.name
        self.fullName.text = self.user.name
        self.email.text = self.user.email
    }

    @IBAction func onUpdateBtnClicked(_ sender: Any) {
        self.user.name = self.fullName.text!
        self.user.email = self.email.text!

        if self.password.text != nil && self.password.text == self.repeatPassword.text {
            self.user.password = self.password.text
        }

        UserService.instance.update(user: self.user) { (success) in
            if success {
                // redirect to all users page
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Failed to add the user")
            }
        }
    }
}
