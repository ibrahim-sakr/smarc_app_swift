//
//  UserService.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/5/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation;
import Alamofire;
import SwiftyJSON;

class UserService: IntegrateSocketProtocol {

    static let instance = UserService();

    public private(set) var users: [User] = [User]()

    func all(completion: @escaping CompletionHandler) -> Void {

        Alamofire.request(UserConst.INDEX_URL, method: .get, encoding: JSONEncoding.default, headers: CoreConst.AUTH_HEADERS)
        .responseJSON{(response) in

            if response.result.error == nil {
                guard let data = response.data else { return };
                self.users = try! JSONDecoder().decode([User].self, from: data);

                completion(true);
            } else {
                completion(false);
            }

        }

    }

    func notify(data: JSON) {
        print("Light Data Comming")
    }

}
