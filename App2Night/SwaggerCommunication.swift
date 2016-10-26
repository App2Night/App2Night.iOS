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
    
    
    // MARK: getPartiesArray()
    public static func getPartiesArray() -> [Party]? {
        return parties
    }
    
    // MARK: getParty()
    public static func getParty() {
        Alamofire.request(self.partyUrl).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            self.parseParty(pResponseData: response.result.value as! [[String: AnyObject]])
        }
    }
    
    // MARK: parseParty()
    private static func parseParty(pResponseData: [[String: AnyObject]]) {
        for Dictionary in pResponseData {
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
        self.printArray()
    }
    
    // MARK: postParty()
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
    
    // MARK: printArray()
    private static func printArray() {
        for Party in self.parties! {
            let tmp = Party.getPartyName()
            print(tmp)
        }
    }
    
}

