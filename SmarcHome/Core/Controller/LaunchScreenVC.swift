//
//  LaunchScreenVC.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/30/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import UIKit

class LaunchScreenVC: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var logoCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoName: UILabel!
    @IBOutlet weak var logoLoading: UILabel!

    let transition = PopAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Launch Screen VC Loaded");
        if AuthService.instance.isLoggedIn {
            animateToHomePage()
        } else {
            animateToMainPage()
        }
    }

    func animateToMainPage() {
        UIView.animate(withDuration: 1.0, animations: {
            self.logoLoading.alpha = 0
            self.logoName.alpha = 0

            self.logoTopConstraint.constant = 60
            self.logoWidthConstraint.constant = 50
            self.logoHeightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }) { (success) in
            if success {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "MainPage")
                nextVC.transitioningDelegate = self
                self.present(nextVC, animated: true, completion: nil)
            }
        }
    }

    func animateToHomePage() {
        UIView.animate(withDuration: 1.0, animations: {
            self.logoLoading.alpha = 0
            self.logoName.alpha = 0

            self.logoTopConstraint.constant = 14
            self.logoWidthConstraint.constant = 30
            self.logoHeightConstraint.constant = 30
            self.view.layoutIfNeeded()
        }) { (success) in
            if success {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
                let nextVC = storyBoard.instantiateViewController(withIdentifier: "HomePage")
                nextVC.transitioningDelegate = self
                self.present(nextVC, animated: true, completion: nil)
            }
        }
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }

}
