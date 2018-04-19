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
    static let BASE_API_URL = "http://\(SettingsService.instance.serverIp):\(SettingsService.instance.serverPort)";
    static let BASE_SOCKET_URL = "http://\(SettingsService.instance.socketIp):\(SettingsService.instance.socketPort)";
    static let SOCKET_INCOME_DATA = "dataIncome";    
    static let STORYBOARD_ID = "Core";
    static let MAIN_PAGE_ID = "MainPage";
    static let HOME_PAGE_ID = "HomePage";
    static let HEADERS = [
        "Content-Type": "application/json"
    ];
    static let AUTH_HEADERS = [
        "token": AuthService.instance.token,
        "Content-Type": "application/json"
    ];
}
