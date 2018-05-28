//
//  MainVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/2/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//
import UIKit

class MainVC: UIViewController {

    private let load: Load = Load()

    override func viewDidLoad() {
        super.viewDidLoad();
    }

    override func viewDidAppear(_ animated: Bool) {
        self.load.origin = self
        self.load.app()
    }

    @IBAction func onDemoBtnClicked(_ sender: Any) {
        let alert = UIAlertController(title: CoreConst.DEMO_ALERT_TITLE, message: CoreConst.DEMO_ALERT_MESSAGE, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: CoreConst.DEMO_ALERT_OK, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func onLoginBtnClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: AuthConst.STORYBOARD_ID, bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: AuthConst.LOGIN_PAGE_ID)
        self.present(nextVC, animated: true, completion: nil)
    }

    @IBAction func onSettingsBtnClicked(_ sender: Any) {
        self.load.settingsPage()
    }

}
