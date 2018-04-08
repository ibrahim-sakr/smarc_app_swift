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
    static let BASE_URL = "http://127.0.0.1:3100";
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
