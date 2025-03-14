//
//  NetworkExtension.swift
//  FreeVPN
//
//  Created by P Deepanshu on 14/03/25.
//

import NetworkExtension

class PacketTunnelProvider: NEPacketTunnelProvider {
    private var vpnEngine: VPNEngineWrapper?
    
    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        let netwrkSettings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: "10.0.0.1")
        
        // Configure IPv4 settings
        let ipv4Settings = NEIPv4Settings(addresses: ["192.168.1.1"], subnetMasks: ["255.255.255.0"])
        ipv4Settings.includedRoutes = [NEIPv4Route.default()]
        netwrkSettings.ipv4Settings = ipv4Settings
        
        // Set DNS settings
        netwrkSettings.dnsSettings = NEDNSSettings(servers: ["8.8.8.8", "8.8.4.4"])
        
        //Intialize the Rust VPN engine
        self.vpnEngine = VPNEngineWrapper()
        
        // Start the VPN Engine
        do {
            try self.vpnEngine?.start(withFileDescriptor: self.pocketFlow.value(forKey: "socket") as! Int32)
            // Apply the network settings
            self.setTunnelNetworkSettings(netwrkSettings) { error in
                if let error = error {
                    NSLog("Failed to set tunnel network settings: \(error.localizedDescription)" )
                    completionHandler(error)
                    return
                }
                
                NSLog("VPN tunnel started successfully")
                completionHandler(nil)
            }
        } catch {
            NSLog("Failed to start VPN engine: \(error.localizedDescription)")
            completionHandler(error)
        }
    }
    
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        // Stop the Rust VPN engine
        self.vpnEngine?.stop()
        self.vpnEngine = nil
        
        NSLog("VPN tunnel stopped")
        completionHandler()
    }
    
    override func handleAppMessage(_ messageData: Data, completionHandler: ((Data?) -> Void)?) {
        // Handle messages from the main app
        if let message = String(data: messageData, encoding: .utf8) {
            NSLog("Received message from app: \(message)")
            
            // Process the messaage with the VPN engine
            if let response = self.vpnEngine?.processAppMessage(message) {
                completionHandler?(Data(response.utf8))
            } else {
                completionHandler?(nil)
            }
        } else {
            completionHandler?(nil)
        }
    }
}
