//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 22.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import Alamofire

class SwaggerCommunication {
    
    public static let baseUrl = "http://app2nightapi.azurewebsites.net/api/"
    public static let partyUrl = baseUrl + "Party"
    
    public static var parties: [Party]?
    
    public static func getParty() {
        // Alamofire request
        Alamofire.request(partyUrl).responseJSON { response in
            // falls json != NULL
            if let json = response.result.value {
                parties = [Party]()
                // für jedes Dictionary innerhalb des JSON Arrays (jede Party)
                for Dictionary in json as! [[String: AnyObject]] {
                    // Party Model
                    // Swift Dictionary zu NSDictionary casten (sind identisch)
                    let partyDictionary = Dictionary as NSDictionary
                    // neues Party Objekt mit dem jeweiligen Dictionary erstellen
                    let party = Party(fromDictionary: partyDictionary)
                    
                    // Host Model
                    let hostDictionary = Dictionary["host"] as! NSDictionary
                    let host = Host(fromDictionary: hostDictionary)
                    // Referenz auf Host Objekt
                    party.host = host
                    
                    // Location Model
                    let locationDictionary = Dictionary["location"] as! NSDictionary
                    let location = Location(fromDictionary: locationDictionary)
                    // Referenz auf Host Objekt
                    party.location = location
                    
                    // Party Objekt in Parties Array anhängen
                    parties?.append(party)
                }
            }
            // printArray()
        }
    }
    
    public static func printArray() {
        for Party in parties! {
            let tmp = Party.location.cityName
            print(tmp)
        }
    }
    
    
}

