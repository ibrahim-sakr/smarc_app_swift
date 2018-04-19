//
//  SettingsService.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/18/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation

class SettingsService {

    static let instance = SettingsService();

    private let defaults = UserDefaults.standard;

    public var serverIp: String {
        get {
            return defaults.string(forKey: "serverIp") != nil ? defaults.string(forKey: "serverIp")! : ""
        }
        set {
            defaults.set(newValue, forKey: "serverIp")
        }
    }

    public var serverPort: String {
        get {
            return defaults.string(forKey: "serverPort") != nil ? defaults.string(forKey: "serverPort")! : ""
        }
        set {
            defaults.set(newValue, forKey: "serverPort")
        }
    }
    
    public var socketIp: String {
        get {
            return defaults.string(forKey: "socketIp") != nil ? defaults.string(forKey: "socketIp")! : ""
        }
        set {
            defaults.set(newValue, forKey: "socketIp")
        }
    }

    public var socketPort: String {
        get {
            return defaults.string(forKey: "socketPort") != nil ? defaults.string(forKey: "socketPort")! : ""
        }
        set {
            defaults.set(newValue, forKey: "socketPort")
        }
    }

}
