//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 22.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import Alamofire

public class SwaggerCommunication {
    
    // MARK: Variables
    private static let baseUrl = "http://app2nightapi.azurewebsites.net/api/"
    private static let partyUrl = baseUrl + "Party"
    private static var parties: [Party]? = [Party]()
    
    // with closures; not working!
    /*
    public static func request(pURL: String, success:@escaping (Any?) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(pURL).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let responseData = responseObject.result.value
                success(responseData)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    public static func getParty() {
        request(pURL: partyUrl, success: {
            (responseData) -> Void in
            if let jsonData = responseData {
                // parties = [Party]()
                // für jedes Dictionary innerhalb des JSON Arrays (jede Party)
                for Dictionary in jsonData as! [[String: AnyObject]] {
                    // Party Model
                    // Swift Dictionary zu NSDictionary casten (sind identisch)
                    let partyDictionary = Dictionary as NSDictionary
                    // neues Party Objekt mit dem jeweiligen Dictionary erstellen
                    let party = Party(pDictionary: partyDictionary)
                    
                    // Host Model
                    let hostDictionary = Dictionary["host"] as! NSDictionary
                    let host = Host(pDictionary: hostDictionary)
                    // Referenz auf Host Objekt
                    party.setHost(pHost: host)
                    
                    /*
                    // Host.Location Model
                    let hostLocationDictionary = Dictionary["host"]?["location"] as! NSDictionary
                    let hostLocation = Location(pDictionary: hostLocationDictionary)
                    // Referenz auf Host Objekt
                    party.getHost().setLocation(pLocation: hostLocation)
                    */
                    
                    // Location Model
                    let locationDictionary = Dictionary["location"] as! NSDictionary
                    let location = Location(pDictionary: locationDictionary)
                    // Referenz auf Host Objekt
                    party.setLocation(pLocation: location)
                    
                    // Party Objekt in Parties Array anhängen
                    parties?.append(party)
                }
            }
        }) {
            (error) -> Void in
            print(error)
        }
    }
    */
    
    // old code
    public static func getParty() {
        Alamofire.request(partyUrl).responseJSON { response in
            if let json = response.result.value {
                for Dictionary in json as! [[String: AnyObject]] {
                    let partyDictionary = Dictionary as NSDictionary
                    let party = Party(pDictionary: partyDictionary)
                    
                    let hostDictionary = Dictionary["host"] as! NSDictionary
                    let host = Host(pDictionary: hostDictionary)
                    party.setHost(pHost: host)
                    
                    /*
                    let hostLocationDictionary = Dictionary["host"]?["location"] as! NSDictionary
                    let hostLocation = Location(fromDictionary: hostLocationDictionary)
                    party.host.location = hostLocation
                    */
                    
                    let locationDictionary = Dictionary["location"] as! NSDictionary
                    let location = Location(pDictionary: locationDictionary)
                    party.setLocation(pLocation: location)
                    
                    parties?.append(party)
                }
            }
            printArray()
        }
    }
    
    public static func postParty() {
        let testParty = [
            "partyName": "iOS Post Test 2",
            "partyDate": "2016-10-25T17:12:22.865Z",
            "musicGenre": 0,
            "location": [
                "countryName": "string",
                "cityName": "string",
                "streetName": "string",
                "houseNumber": 0,
                "houseNumberAdditional": "string",
                "zipcode": 0,
                "latitude": 0,
                "longitude": 0
            ],
            "partyType": 0,
            "description": "string"
        ] as [String: Any]
        
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
    
    public static func printArray() {
        for Party in parties! {
            let tmp = Party.getPartyName()
            print(tmp)
        }
    }
    
}

