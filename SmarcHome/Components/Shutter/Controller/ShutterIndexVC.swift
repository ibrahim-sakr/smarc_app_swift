//
//  ShutterIndexVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/8/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class ShutterIndexVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onHomeBtnClicked() {
        let storyBoard: UIStoryboard = UIStoryboard(name: CoreConst.STORYBOARD_ID, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: CoreConst.HOME_PAGE_ID)
        self.present(newViewController, animated: true, completion: nil)
    }

}
