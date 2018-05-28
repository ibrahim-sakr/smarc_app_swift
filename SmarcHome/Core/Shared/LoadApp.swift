//
//  LoadApp.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 5/6/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

class Load {
    var origin: UIViewController!

    func settingsPage() {
        let storyBoard: UIStoryboard = UIStoryboard(name: SettingsConst.STORYBOARD_ID, bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: SettingsConst.SETTINGS_PAGE_ID)
        self.origin.present(nextVC, animated: true, completion: nil)
    }

    func displayNoInternetConnectionAlert() {
        let alert = UIAlertController(title: CoreConst.NO_INTERNET_CONNECTION_ALERT_TITLE, message: CoreConst.NO_INTERNET_CONNECTION_ALERT_MESSAGE, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: CoreConst.NO_INTERNET_CONNECTION_ALERT_RELOAD, style: .default, handler: { action in
            self.app()
        }))

        self.origin.present(alert, animated: true, completion: nil)
    }

    func displayNoServerFoundAlert() {
        let alert = UIAlertController(title: CoreConst.NO_SERVER_ALERT_TITLE, message: CoreConst.NO_SERVER_ALERT_MESSAGE, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: CoreConst.NO_SERVER_ALERT_RELOAD, style: .default, handler: { action in
            self.app()
        }))

        alert.addAction(UIAlertAction(title: CoreConst.NO_SERVER_ALERT_SETTINGS, style: .default, handler: { action in
            self.settingsPage()
        }))

        self.origin.present(alert, animated: true, completion: nil)
    }

    func checkServerExistence(_ complete: @escaping CompletionHandler) {
        AuthService.instance.checkHand { (success) in
            if success {
                complete(true)
            } else {
                complete(false)
            }
        }
    }

    func app() {
        // Check Internet Connection
        NetworkManager.isUnreachable { (unReachable) in
            if unReachable {
                return self.displayNoInternetConnectionAlert()
            }

            // Check Server Existence
            self.checkServerExistence({ (found) in
                if !found {
                    return self.displayNoServerFoundAlert()
                }

                // if user is LoggedIn so no need to stay here at all
                // and redirect to home page
                if AuthService.instance.isLoggedIn {
                    let storyBoard: UIStoryboard = UIStoryboard(name: CoreConst.STORYBOARD_ID, bundle: nil)
                    let nextVC = storyBoard.instantiateViewController(withIdentifier: CoreConst.HOME_PAGE_ID)
                    self.origin.present(nextVC, animated: true, completion: nil)
                } else {
                    // hide loading page and let user logging in
                }
            })
        }
    }

}
