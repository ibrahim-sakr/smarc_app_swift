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
    static let BASE_API_URL = "http://127.0.0.1:3100";
    static let BASE_SOCKET_URL = "http://127.0.0.1:3101";
    
    static let SOCKET_INCOME_DATA = "dataIncome";
//    static let SIREN_INCOME_ID = "sirenIncome";
//    static let SECURITY_INCOME_ID = "securityIncome";
//    static let SCENE_INCOME_ID = "sceneIncome";
//    static let ROOM_INCOME_ID = "roomIncome";
//    static let MUSIC_INCOME_ID = "musicIncome";
//    static let MOTOR_INCOME_ID = "motorIncome";
//    static let DOOR_INCOME_ID = "doorIncome";
//    static let LIGHT_INCOME_ID = "lightIncome";
//    static let CAM_INCOME_ID = "camIncome";
    
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
