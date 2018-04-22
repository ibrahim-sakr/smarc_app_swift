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

class UserService {

    static let instance = UserService();
    
    public private(set) var users: [User] = []

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

    func update(user: User, completion: @escaping CompletionHandler) {
        Alamofire.request(UserConst.UPDATE_URL, method: .put, parameters: user.dictionary, encoding: JSONEncoding.default, headers: CoreConst.AUTH_HEADERS)
            .responseJSON{(response) in
                if response.result.error == nil {
                    // do this staff from SocketIO
//                    guard let data = response.data else { return };
//                    let user = try! JSONDecoder().decode(User.self, from: data);
//                    if let i = self.users.index(where: { $0._id == user._id }) {
//                        self.users[i] = user
//                    }

                    completion(true);
                } else {
                    completion(false);
                }
        }
    }

    func delete(id: String, completion: @escaping CompletionHandler) {
        Alamofire.request(UserConst.DELETE_URL + id, method: .delete, encoding: JSONEncoding.default, headers: CoreConst.AUTH_HEADERS)
            .responseJSON{(response) in
                if response.result.error == nil {
                    // do this staff from SocketIO
//                    if let i = self.users.index(where: { $0._id == id }) {
//                        self.users.remove(at: i)
//                    }
                    completion(true);
                } else {
                    completion(false);
                }
        }
    }

}
