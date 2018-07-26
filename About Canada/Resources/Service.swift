//
//  Service.swift
//  About Canada
//
//  Created by Krunal Purohit on 20/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Alamofire
import Foundation


// MARK:- Protocol: AboutServiceDeligate

protocol AboutServiceDeligate: class {
    func handleAboutData(aboutResponse: About) -> Void
    func handleAboutError(aboutError: AboutError) -> Void
}


// MARK:- Service

class Service {
    
    // Shared Instance
    static let shared = Service()
    
    var deligate: AboutServiceDeligate?
    
    
    // MARK:- Public: getAboutData
    
    public func getAboutData() {
        do {
            let network = try Utils.shared.isNetworkAvailable()
            if network {
                Alamofire.request(Constants.serviceURLString).responseString(completionHandler: { (response) in
                    if let dataString = response.value {
                        self.parseJSONString(data: dataString)
                    } else {
                        print(response.error?.localizedDescription ?? AboutError.ServerCallFailure)
                        self.deligate?.handleAboutError(aboutError: AboutError.ServerCallFailure)
                    }
                })
            }
        } catch AboutError.NoNetwork {
            self.deligate?.handleAboutError(aboutError: AboutError.NoNetwork)
        } catch AboutError.InvalidJSON {
            self.deligate?.handleAboutError(aboutError: AboutError.InvalidJSON)
        } catch {
            print(#imageLiteral(resourceName: "error").description)
            self.deligate?.handleAboutError(aboutError: AboutError.ServerCallFailure)
        }
    }
    
    
    // MARK:- Private:
    
    private init() {}
    
    private func parseJSONString(data: String) {
        do {
            let aboutData = try Utils.shared.parseData(data: data)
            self.deligate?.handleAboutData(aboutResponse: aboutData)
        } catch {
            self.deligate?.handleAboutError(aboutError: AboutError.InvalidJSON)
        }
    }
}
