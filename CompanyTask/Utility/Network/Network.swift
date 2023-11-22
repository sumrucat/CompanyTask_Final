//
//  Network.swift
//  CompanyTask
//
//  Created by Apple on 22/11/23.
//

import Foundation
import SystemConfiguration

class Network {
    
    static let shared = Network()
    
    private init() {}
    
    func makePostRequest(requestData: Data, completion: @escaping (Data?, Bool, String?) -> Void) {
        // URL for the API endpoint
        guard let url = URL(string: APIConstants.baseURL) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = requestData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if isConnectedToNetwork() {
            // Make the network request
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(nil, false, error.localizedDescription)
                    return
                }

                guard let data = data else {
                    completion(nil, false, "NO DATA FOUND")
                    return
                }
                self.getPrintableStringWith(inputOrOutput: false, data)
                completion(data, true, nil)
            }.resume()
        } else {
            completion(nil, false, "NO NETWORK")
        }
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }

    
    private func getPrintableStringWith(inputOrOutput: Bool, _ data: Data) {
    #if DEBUG
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                let data = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                if let string = String(data: data, encoding: String.Encoding.utf8) {
                    if inputOrOutput {
                        print("REQUEST JSON:\n\(string)")
                    } else {
                        print("RESPONSE JSON:\n\(string)")
                    }
                }
            }
        } catch {
            print(error)
        }
    #endif
    }
}

