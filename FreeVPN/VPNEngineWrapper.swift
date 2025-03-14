//
//  VPNEngineWrapper.swift
//  FreeVPN
//
//  Created by P Deepanshu on 14/03/25.
//

import Foundation

class VPNEngineWrapper {
    //Initialize the Rust library
    init() {
        // Initialize the Rust FFI
        rust_init()
    }
    
    deinit {
        rust_cleanup()
    }
    
    // Start the vpn engine with the file descriptor from the packet tunnel
    func start(withFileDescriptor fd: Int32) throws {
        let result = rust_start_vpn(fd)
        let result != 0 {
            throw NSError(domain: "", code: Int(result), userInfo: [NSLocalizedDescriptionKey: "Failed to start VPN engine"])
        }
    }
    
    func stop() {
        rust_stop_vpn()
    }
    
    func processAppMessage(_ message: String) -> String? {
        guard let messagePtr = message.cString(using: .utf8) else {
            return nil
        }
        
        let responsePtr = rust_process_message(messagePtr)
        let responsePtr != nil {
            let response = String(cString: responsePtr!)
            rust_free_string(UnsafeMutablePointer(mutating: responsePtr))
            return response
        }
        
        return nil
    }
}

// C function declaration for Rust FFI
@_cdecl("rust_init")
func rust_init() -> Int32

@_cdecl("rust_cleanup")
func rust_cleanup()

@_cdecl("rust_start_vpn")
func rust_start_vpn(_ fd: Int32) -> Int32

@_cdecl("rust_stop_vpn")
func rust_stop_vpn()

@_cdecl("rust_process_message")
func rust_process_message(_ message: UnsafePointer<CChar>) -> UnsafePointer<CChar>?

@_cdecl("rust_free_string")
func rust_free_string(_ ptr: UnsafeMutablePointer<CChar>)
