//
//  CoreConst.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/7/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias CompletionHandler = (_ Sucess: Bool) -> ();

class CoreConst {
    // Colors
    static let green: UIColor = UIColor(red: 109.0/255.0, green: 178.0/255.0, blue: 163.0/255.0, alpha: 1.0)
    static let yellow: UIColor = UIColor(red: 233.0/255.0, green: 205.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    static let orange: UIColor = UIColor(red: 215.0/255.0, green: 138.0/255.0, blue: 95.0/255.0, alpha: 1.0)
    static let gray: UIColor = UIColor(red: 64.0/255.0, green: 80.0/255.0, blue: 94.0/255.0, alpha: 1.0)
    static let red: UIColor = UIColor(red: 206.0/255.0, green: 99.0/255.0, blue: 84.0/255.0, alpha: 1.0)

    static var BASE_API_URL: String {
        return "http://\(SettingsService.instance.serverIp):\(SettingsService.instance.serverPort)"
    }

    static let SOCKET_LOG = false
    static var BASE_SOCKET_URL: String {
        return "http://\(SettingsService.instance.socketIp):\(SettingsService.instance.socketPort)"
    }

    static var AUTH_HEADERS: [String: String] {
        return [
            "token": AuthService.instance.token,
            "Content-Type": "application/json"
        ]
    }

    static let HEADERS = [
        "Content-Type": "application/json"
    ]

    static let SOCKET_INCOME_DATA = "dataIncome"
    static let STORYBOARD_ID = "Core"
    static let MAIN_PAGE_ID = "MainPage"
    static let HOME_PAGE_ID = "HomePage"
    static let NO_INTERNET_CONNECTION_ALERT_TITLE = "Connection"
    static let NO_INTERNET_CONNECTION_ALERT_MESSAGE = "No Active Internet Connection,\nPlease make sure you are connected then try again."
    static let NO_INTERNET_CONNECTION_ALERT_RELOAD = "Reload"
    
    static let NO_SERVER_ALERT_TITLE = "Server"
    static let NO_SERVER_ALERT_MESSAGE = "Can't Connect to the Server,\nPlease make sure you typed the settings correctly then try again."
    static let NO_SERVER_ALERT_RELOAD = "Reload"
    static let NO_SERVER_ALERT_SETTINGS = "Settings"
    
    static let DEMO_ALERT_TITLE = "Sorry!!"
    static let DEMO_ALERT_MESSAGE = "the demo is Not ready yet.\nplease try to login"
    static let DEMO_ALERT_OK = "OK"
    
    static let HOME_BUTTONS_CELL_ID = "homeButton"
}
