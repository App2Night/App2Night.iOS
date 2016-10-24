//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 22.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

class SwaggerCommunication {
    
    // Basis URL der Swagger API
    static let basisUrl : String = "http://app2nightapi.azurewebsites.net/api/"
    
    public class func getParty () {
        // URL mit Party Suffix
        let fullUrl = basisUrl + "Party"
        
        // GET-Request an die API
        Alamofire.request(fullUrl)
            .validate()
            .responseJSON { response in
                if let json = response.result.value {
                    print("\(json)")
                }
        }
    }
    
}
