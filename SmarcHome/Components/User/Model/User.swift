//
//  User.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/5/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

struct User: Decodable {
    public private(set) var _id: String;
    public private(set) var email: String;
    public private(set) var name: String;
}
