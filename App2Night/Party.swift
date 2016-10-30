//
//  Party.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

public class Party {
    
    private var partyId: String!
    private var date: String!
    private var price: Int!
    private var host: Host!
    private var partyName: String!
    private var partyDate: String!
    private var musicGenre: MusicGenre!
    private var location: Location!
    private var partyType: PartyType!
    private var descriptionField: String!
    
    
    // MARK: init empty party object
    init() {
        
    }
    
    // MARK: init from NSDictionary
    init(pDictionary: NSDictionary) {
        date = pDictionary["date"] as? String
        descriptionField = pDictionary["description"] as? String
        musicGenre = pDictionary["musicGenre"] as? MusicGenre
        partyId = pDictionary["partId"] as? String
        partyDate = pDictionary["partyDate"] as? String
        partyName = pDictionary["partyName"] as? String
        partyType = pDictionary["partyType"] as? PartyType
        price = pDictionary["price"] as? Int
    }
    
    // MARK: toDictionary()
    public func toDictionary() -> [String : Any] {
        let jsonDictionary = [
            "partyName": self.getPartyName(),
            "partyDate": self.getPartyDate(),
            "musicGenre": self.getMusicGenre().rawValue,
            "location": [
                "countryName": self.location.getCountryName(),
                "cityName": self.location.getCityName(),
                "streetName": self.location.getStreetName(),
                "houseNumber": self.location.getHouseNumber(),
                "houseNumberAdditional": self.location.getHouseNumberAdditional(),
                "zipcode": self.location.getZipcode(),
                "latitude": self.location.getLatitude(),
                "longitude": self.location.getLongitude()
            ],
            "partyType": self.getPartyType().rawValue,
            "description": self.getDescription()
            ] as [String : Any]
        
        return jsonDictionary
    }
    
    // MARK: GET & SET
    public func getPartyID() -> String {
        return self.partyId
    }
    
    public func setPartyID(pPartyID: String) {
        self.partyId = pPartyID
    }
    
    public func getDate() -> String {
        return self.date
    }
    
    public func setDate(pDate: String) {
        self.date = pDate
    }
    
    public func getPrice() -> Int {
        return self.price
    }
    
    public func setPrice(pPrice: Int) {
        self.price = pPrice
    }
    
    public func getHost() -> Host {
        return self.host
    }
    
    public func setHost(pHost: Host) {
        self.host = pHost
    }
    
    public func getPartyName() -> String {
        return self.partyName
    }
    
    public func setPartyName(pPartyName: String) {
        self.partyName = pPartyName
    }
    
    public func getPartyDate() -> String {
        return self.partyDate
    }
    
    public func setPartyDate(pPartyDate: String) {
        self.partyDate = pPartyDate
    }
    
    public func getMusicGenre() -> MusicGenre {
        return self.musicGenre
    }
    
    public func setMusicGenre(pMusicGenre: MusicGenre) {
        self.musicGenre = pMusicGenre
    }
    
    public func getLocation() -> Location {
        return self.location
    }
    
    public func setLocation(pLocation: Location) {
        self.location = pLocation
    }
    
    public func getPartyType() -> PartyType {
        return self.partyType
    }
    
    public func setPartyType(pPartyType: PartyType) {
        self.partyType = pPartyType
    }
    
    public func getDescription() -> String {
        return self.descriptionField
    }
    
    public func setDescription(pDescription: String) {
        self.descriptionField = pDescription
    }
    
    
}

