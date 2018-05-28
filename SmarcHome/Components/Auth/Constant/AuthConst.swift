//
//  AuthConst.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/4/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

class AuthConst {
    static var LOGIN_URL: String {
        let base_url = CoreConst.BASE_API_URL
        return "\(base_url)/auth/token"
    }
    
    static var CHECKHAND_URL: String {
        let base_url = CoreConst.BASE_API_URL
        return "\(base_url)/checkhand"
    }

    static let STORYBOARD_ID = "Auth";
    static let FORGET_PASSWORD_PAGE = "ForgetPasswordPage"
    static let LOGIN_PAGE_ID = "LoginPage"

    static let LOGGED_IN_KEY = "loggedin"
    static let TOKEN_KEY = "token"
    static let USER_KEY = "user"
    static let EMAIL_KEY = "email"
    static let NAME_KEY = "name"
    static let PASSWORD_KEY = "password"
    
    static let ALERT_TITLE = "Alert"
    static let ALERT_MESSAGE = "Login Failed"
    static let ALERT_ACTION_RETRY = "Retry"
    static let ALERT_ACTION_EXIT = "Exit"
}
