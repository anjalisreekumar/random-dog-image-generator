//
//  NetworkConnectivity.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 17/01/25.
//

import Foundation
import Network

class NetworkConnectivity {
    private let monitor = NWPathMonitor()
    private let queue: DispatchQueue
    
    static let shared = NetworkConnectivity()
    
    var isConnected: Bool {
        return monitor.currentPath.status == .satisfied
    }
    
    private init(){
        queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                print("No connection.")
            }
        }
        
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    
}
