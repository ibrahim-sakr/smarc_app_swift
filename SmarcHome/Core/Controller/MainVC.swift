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
    }

    override func viewDidAppear(_ animated: Bool) {
        self.loadSmarc()
    }

    @IBAction func onDemoBtnClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Sorry!!", message: "the demo is Not ready yet.\nplease try to login", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func onLoginBtnClicked(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "LoginPage")
        self.present(nextVC, animated: true, completion: nil)
    }

    @IBAction func onSettingsBtnClicked(_ sender: Any) {
        self.goToSettingsPage()
    }
    
    func goToSettingsPage() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "SettingsPage")
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func displayNoInternetConnectionAlert() {
        print("displayNoInternetConnectionAlert => No Internet Connection Alert");
        
        let alert = UIAlertController(title: "Connection", message: "No Active Internet Connection,\nPlease make sure you are connected then try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { action in
            self.loadSmarc()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func displayNoServerFoundAlert() {
        print("displayNoServerFoundAlert => No Server Found Alert");

        let alert = UIAlertController(title: "Server", message: "Can't Connect to the Server,\nPlease make sure you typed the settings correctly then try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { action in
            self.loadSmarc()
        }))

        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
             self.goToSettingsPage()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func checkServerExistence(_ complete: @escaping CompletionHandler) {
        print("checkServerExistence => Check Server Existence")
        AuthService.instance.checkHand { (success) in
            if success {
                print("checkServerExistence => Server Found")
                complete(true)
            } else {
                print("checkServerExistence => Server Not Found")
                complete(false)
            }
        }
    }

    func loadSmarc() {
        print("Load Smarc")
        // Check Internet Connection
        print("loadSmarc => Check Network")
        NetworkManager.isUnreachable { (unReachable) in
            if unReachable {
                print("loadSmarc => Network UnReachable")
                return self.displayNoInternetConnectionAlert()
            }

            // Check Server Existence
            print("loadSmarc => Check Server Existence")
            self.checkServerExistence({ (found) in
                if !found {
                    print("loadSmarc => Server Not Found")
                    return self.displayNoServerFoundAlert()
                }

                // if user is LoggedIn so no need to stay here at all
                // and redirect to home page
                print("loadSmarc => Check Auth")
                if AuthService.instance.isLoggedIn {
                    print("loadSmarc => User Authed")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Core", bundle: nil)
                    let nextVC = storyBoard.instantiateViewController(withIdentifier: "HomePage")
                    self.present(nextVC, animated: true, completion: nil)
                } else {
                    print("loadSmarc => User NOT Authed")
                    // hide loading page and let user logging in
                }
            })
        }
    }
    
}























