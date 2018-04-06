//
//  UserService.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/5/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserService {

    func all() {
        Alamofire.request(USER_INDEX_URL, method: .get, encoding: JSONEncoding.default, headers: AUTH_HEADERS).responseJSON{(response) in
            if response.result.error == nil {
                print("all users");
            } else{
                print("failed to fetch users")
            }
        }
    }

}
