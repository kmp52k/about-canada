//
//  Service.swift
//  About Canada
//
//  Created by Krunal Purohit on 20/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Alamofire
import Foundation


// MARK:- Protocol: AboutServiceDelegate

protocol AboutServiceDelegate: class {
    func handleAboutData(aboutResponse: AboutViewModel) -> Void
    func handleAboutError(aboutError: AboutError) -> Void
}


// MARK:- Service

class Service {
    
    // Shared Instance
    static let shared = Service()
    
    var delegate: AboutServiceDelegate?
    
    
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
                        self.delegate?.handleAboutError(aboutError: AboutError.ServerCallFailure)
                    }
                })
            }
        } catch AboutError.NoNetwork {
            self.delegate?.handleAboutError(aboutError: AboutError.NoNetwork)
        } catch AboutError.InvalidJSON {
            self.delegate?.handleAboutError(aboutError: AboutError.InvalidJSON)
        } catch {
            print(#imageLiteral(resourceName: "error").description)
            self.delegate?.handleAboutError(aboutError: AboutError.ServerCallFailure)
        }
    }
    
    
    // MARK:- Private:
    
    private init() {}
    
    private func parseJSONString(data: String) {
        do {
            let aboutData = try Utils.shared.parseData(data: data)
            let aboutViewModel = AboutViewModel(about: aboutData)
            self.delegate?.handleAboutData(aboutResponse: aboutViewModel)
        } catch {
            self.delegate?.handleAboutError(aboutError: AboutError.InvalidJSON)
        }
    }
}
