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

class UserService: IntegrateSocketProtocol, RefreshableProtocol {

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
        Alamofire.request(UserConst.INDEX_URL, method: .put, parameters: user.dictionary, encoding: JSONEncoding.default, headers: CoreConst.AUTH_HEADERS)
            .responseJSON{(response) in
                if response.result.error == nil {
                    completion(true);
                } else {
                    completion(false);
                }
        }
    }

    func delete(id: String, completion: @escaping CompletionHandler) {
        let parameters = [
            "id": id
        ]
        Alamofire.request(UserConst.INDEX_URL, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: CoreConst.AUTH_HEADERS)
            .responseJSON{(response) in
                if response.result.error == nil {
                    completion(true);
                } else {
                    completion(false);
                }
        }
    }

    func notify(data: JSON) {
        switch data["action"].stringValue {
        case UserConst.ACTION_DELETE:
            self.notifyDelete(deletedUser: data);
        case UserConst.ACTION_UPDATE:
            self.notifyUpdate(updatedUser: data);
        default:
            print("No Action Specified")
        }
    }
    
    func notifyDelete(deletedUser: JSON) {
        // if the deleted user is the current one
        if AuthService.instance.user["_id"].stringValue == deletedUser["_id"].stringValue {
            // LOGOUT now
            AuthService.instance.logout()
            // redirect to Login Page
        } else {
            // just remove deletedUser from self.users
            if let i = self.users.index(where: { $0._id == deletedUser["_id"].stringValue }) {
                self.users.remove(at: i)
            }
        }
    }

    func notifyUpdate(updatedUser: JSON) {
        var user = User()
        user._id = updatedUser["_id"].stringValue
        user.email = updatedUser["email"].stringValue
        user.name = updatedUser["name"].stringValue
        if let i = self.users.index(where: { $0._id == user._id }) {
            self.users[i] = user
        }
    }
    
    func refresh(complete: @escaping CompletionHandler) {
        self.users = []
        self.all { (success) in
            if success {
                complete(true)
            } else {
                complete(false)
            }
        }
    }
    
}
