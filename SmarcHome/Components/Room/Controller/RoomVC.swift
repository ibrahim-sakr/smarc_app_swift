//
//  RoomVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/24/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class RoomVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToHome() {
        let controller = UIStoryboard(name: "Room", bundle: nil).instantiateViewController(withIdentifier: "<#T##String#>")
    }

}
