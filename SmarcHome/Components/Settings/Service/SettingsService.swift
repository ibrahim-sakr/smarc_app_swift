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
            if let data = defaults.string(forKey: "serverIp") {
                return data
            } else {
                return ""
            }
        }
        set {
            defaults.set(newValue, forKey: "serverIp")
        }
    }

    public var serverPort: String {
        get {
            if let data = defaults.string(forKey: "serverPort") {
                return data
            } else {
                return ""
            }
        }
        set {
            defaults.set(newValue, forKey: "serverPort")
        }
    }

    public var socketIp: String {
        get {
            if let data = defaults.string(forKey: "socketIp") {
                return data
            } else {
                return ""
            }
        }
        set {
            defaults.set(newValue, forKey: "socketIp")
        }
    }

    public var socketPort: String {
        get {
            if let data = defaults.string(forKey: "socketPort") {
                return data
            } else {
                return ""
            }
        }
        set {
            defaults.set(newValue, forKey: "socketPort")
        }
    }

}
