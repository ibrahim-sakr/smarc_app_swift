//
//  NetworkManager.swift
//  SmarcHome
//
//  Created by Ibrahim Saqr on 4/22/18.
//  Copyright © 2018 Ibrahim Saqr. All rights reserved.
//

import Foundation
import Reachability

class NetworkManager {

    static let instance = NetworkManager()

    public var reachability: Reachability!

    init() {
        // Initialise reachability
        self.reachability = Reachability()!

        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )

        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
        print("Network Status Canged")

        // check the new state of network, then take the right Action
    }

    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManager.instance.reachability).startNotifier()
        } catch {
            print("Error When Stopping Notifier")
        }
    }

    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.instance.reachability).connection != .none {
            completed(NetworkManager.instance)
        }
    }
    
    // Network is unreachable
    static func isUnreachable(completed: @escaping CompletionHandler) {
        if (NetworkManager.instance.reachability).connection == .none {
            return completed(true)
        }
        return completed(false)
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.instance.reachability).connection == .cellular {
            completed(NetworkManager.instance)
        }
    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.instance.reachability).connection == .wifi {
            completed(NetworkManager.instance)
        }
    }

}
