//
//  AuthService.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/3/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import KeychainSwift

class AuthService {
    
    static let instance = AuthService();
    let defaults = UserDefaults.standard;
    private let keychain = KeychainSwift();
    private var userTemp: JSON = JSON("{}")
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY);
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY);
        }
    }
    
    var token: String {
        get {
            return self.keychain.get(TOKEN_KEY)!
        }
        set {
            self.keychain.set(newValue, forKey: TOKEN_KEY)
        }
    }

    var user: JSON {
        get {
            if self.userTemp["_id"].string != nil {
                return self.userTemp
            } else {
                let value = self.keychain.get(USER_KEY)!
                let valueToData = value.data(using: .utf8, allowLossyConversion: false)
                var json: JSON = JSON()
    
                do {
                    json = try JSON(data: valueToData!)
                    self.userTemp = json
                } catch {
                    print("GET USER ERROR")
                    return self.userTemp
                }
                return json
            }
        }
        set {
            self.userTemp = newValue
            self.keychain.set(newValue.description, forKey: USER_KEY)
        }
    }

    func login(email: String, password: String, completion: @escaping CompletionHandler) -> Void {
        let body = [
            "email": email.lowercased(),
            "password": password
        ];
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADERS).responseJSON{(response) in
            if response.result.error == nil {
                do {
                    guard let data = response.data else { return };
                    let json = try JSON(data: data);
                    self.user = json["user"];
                    self.token = json["token"].stringValue;
                    self.isLoggedIn = true;
                    completion(true);
                } catch let error as NSError {
                    completion(false);
                    print(error);
                }
            } else {
                completion(false);
                print(response.result.error as Any)
            }
        }
    }

    func logout() -> Void {
        self.token = "";
        self.user = JSON("{}");
        self.isLoggedIn = false;
    }
}
