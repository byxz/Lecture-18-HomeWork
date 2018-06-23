//
//  APICrimeData.swift
//  API-project
//
//  Created by Mac on 22.06.2018.
//  Copyright © 2018 testOrg. All rights reserved.
//

import Foundation


enum Type: FinalURLPoint {
    var baseURL: URL {
        return URL(string: "https://stroccoli-sebasfreetest-v1.p.mashape.com/calendar")!
    }
    
    var path: String {
        switch self {
        case .Current(let apiKey, let name):
            return "/key/\(apiKey)/\(name)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
    
    case Current(apiKey: String, name: String)
}

final class APICrimeData: APIManager {
    func fetch<T>(request: URLRequest, parse: ([String : AnyObject]) -> T?, completionHandler: (APIResult<T>) -> Void) {
        print ("xz")
    }
    
   
    var sessionConfiguration: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    } ()
    
    let apiKey: String
    
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchData(name: String, comletionHandler: (APIResult<CurrentData>)) -> Void {
        let request = Type.Current(apiKey: self.apiKey, name: name).request
        
        fetch(request: request, parse: { (json) -> CurrentData? in
            if let dictionary = json["home_team"] as? [String: AnyObject] {
                return CurrentData(JSON: dictionary)
            } else {
                return nil
                
            }
        }, completionHandler: comletionHandler)
        
    }
    
}
