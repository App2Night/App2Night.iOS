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
    
    // TODO: ERROR/NULL handling
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
                    
                    /*
                    // Host.Location Model
                    let hostLocationDictionary = Dictionary["host"]?["location"] as! NSDictionary
                    let hostLocation = Location(fromDictionary: hostLocationDictionary)
                    // Referenz auf Host Objekt
                    party.host.location = hostLocation
                    */
                    
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
            let tmp = Party.host.username
            print(tmp)
        }
    }
    
    // TODO: Kommentare, saubere Übergabe von Dictionary eines Party Objekts (neue Funktion in Klasse; Konstruktor überladen), ERROR/NULL handling
    public static func postParty() {
        
        let testParty = [
            "partyName": "iOS Test Party",
            "partyDate": "2022-2-22T22:22:22.222Z",
            "musicGenre": 0,
            "location": [
                "countryName": "United States",
                "cityName": "Cupertino",
                "streetName": "Pruneridge Avenue",
                "houseNumber": 19111,
                "houseNumberAdditional": "CA 95014",
                "zipcode": 95014,
                "latitude": 37,
                "longitude": -122,
            ],
            "partyType": 0,
            "description": "iOS Party."
        ] as [String : Any]
        
        let postUrl = URL(string: partyUrl)
        var request = URLRequest(url: postUrl!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: testParty)
        
        Alamofire.request(request)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                }
        }
    }
    
}

