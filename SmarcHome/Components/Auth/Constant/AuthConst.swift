//
//  AuthConst.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/4/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

let LOGGED_IN_KEY = "loggedin";
let TOKEN_KEY = "token";
let USER_KEY = "user";
let EMAIL_KEY = "email";
let NAME_KEY = "name";

let BASE_URL = "http://127.0.0.1:3100";
let LOGIN_URL = "\(BASE_URL)/user/auth";

typealias CompletionHandler = (_ Sucess: Bool) -> ();

let HEADERS = [
    "Content-Type": "application/json"
];

let AUTH_HEADERS = [
    "token": "Berear \(AuthService.instance.token)",
    "Content-Type": "application/json"
];
