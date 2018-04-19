//
//  User.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/5/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

struct User: Decodable {
    public var _id: String!
    public var email: String!
    public var name: String!
    public var password: String!
    public private(set) var dictionary: [String: Any] {
        get {
            return [
                "_id": _id!,
                "email": email!,
                "name": name!,
                "password": password != nil ? password : "",
            ]
        }
        set {}
    }
}
