//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 22.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

/*
import Foundation
import Alamofire

public class SwaggerCommunication {
	
	public static func getParties(completionHandler: @escaping ([Party]?) -> ()) {
		Alamofire.request(Properties.partyUrl, method: .get).validate().responseJSON { (response) in
			// print response data
			print("***START ALAMOFIRE REQUEST***")
			print("REQUEST URL:\n\(response.request as Any)")
			print("HTTP URL RESPONSE:\n\(response.response as Any)")
			print("SERVER DATA (BYTES):\n\(response.data as Any)")
			print("RESULT OF SERIALIZATION:\n\(response.result as Any)")
			print("VALUE OF THE RESULT:\n\(response.result.value as Any)")
			
			// switch based on serialization result
			switch response.result {
			case .success:
				print("SERIALIZATION SUCCESS.")
				DispatchQueue.main.async(execute: { () -> Void in
					completionHandler(Party.parseResponse(pResponseData: response.result.value))
				})
			case .failure(let error):
				print("SERIALIZATION FAILED.")
				print(error)
			}
			}.resume()
	}
	
	public static func retrieveToken(pUser: User) {
		var request = URLRequest(url: URL(string: Properties.tokenUrl)!)
		request.httpMethod = "POST"
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		let requestString = "client_id=nativeApp&" + "client_secret=secret&" + "grant_type=password&" + "username=" + pUser.getUserName() + "&" + "password=" + pUser.getPassword() + "&" + "scope=App2NightAPI offline_access&" + "offline_access=true"
		let requestData: Data = (requestString as NSString).data(using: String.Encoding.utf8.rawValue)!
		request.httpBody = requestData
		
		Alamofire.request(request).validate().responseJSON { (response) in
			// print response data
			print("***START ALAMOFIRE REQUEST***")
			print("REQUEST URL:\n\(response.request as Any)")
			print("HTTP URL RESPONSE:\n\(response.response as Any)")
			print("SERVER DATA (BYTES):\n\(response.data as Any)")
			print("RESULT OF SERIALIZATION:\n\(response.result as Any)")
			print("VALUE OF THE RESULT:\n\(response.result.value as Any)")
			
			// switch based on serialization result
			switch response.result {
			case .success:
				print("SERIALIZATION SUCCESS.")
			case .failure(let error):
				print("SERIALIZATION FAILED.")
				print(error)
			}
		}
	}
	
	
}
*/


//public static func postParty(pDictionary: [String: Any]) {
//	// post request
//	var postUrl = URLRequest(url: URL(string: Properties.partyUrl)!)
//	postUrl.httpMethod = "POST"
//	postUrl.setValue("application/json", forHTTPHeaderField: "Content-Type")
//	
//	// try json serialization
//	postUrl.httpBody = try! JSONSerialization.data(withJSONObject: pDictionary)
//	
//	Alamofire.request(postUrl).validate().responseJSON { response in
//		// debug messages from response - some are downcasted to any because of warnings xcode 8.1
//		debugPrint(response.request as Any)    // original URL request
//		debugPrint(response.response as Any)   // HTTP URL response
//		debugPrint(response.data as Any)   // server data
//		debugPrint(response.result) // result of response serialization
//		debugPrint(response.result.value as Any)   // value of the response result
//		
//		// switch case success/failure of request
//		switch response.result {
//		case .success:
//			debugPrint("Validation Successful")
//		case .failure(let error):
//			debugPrint(error)
//			if let responseData = response.data, let responseString = String(data: responseData, encoding: .utf8) {
//				print(responseString)
//			}
//		}
//	}
//}
//
//public static func postToken(pUsername: String, pPassword: String) {
//	// post request
//	var postUrl = URLRequest(url: URL(string: Properties.tokenUrl)!)
//	postUrl.httpMethod = "POST"
//	postUrl.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//	
//	// token body data
//	let tokenString = "client_id=nativeApp&" + "client_secret=secret&" + "grant_type=password&" + "username=" + pUsername + "&" + "password=" + pPassword + "&" + "scope=App2NightAPI offline_access&" + "offline_access=true"
//	let tokenData: Data = (tokenString as NSString).data(using: String.Encoding.utf8.rawValue)!
//	
//	postUrl.httpBody = tokenData
//	
//	Alamofire.request(postUrl).validate().responseJSON { response in
//		// debug messages from response - some are downcasted to any because of warnings xcode 8.1
//		debugPrint(response.request as Any)    // original URL request
//		debugPrint(response.response as Any)   // HTTP URL response
//		debugPrint(response.data as Any)   // server data
//		debugPrint(response.result) // result of response serialization
//		debugPrint(response.result.value as Any)   // value of the response result
//		
//		// switch case success/failure of request
//		switch response.result {
//		case .success:
//			debugPrint("Validation Successful")
//			parseToken(pResponseData: response.result.value)
//		case .failure(let error):
//			debugPrint(error)
//			if let responseData = response.data, let responseString = String(data: responseData, encoding: .utf8) {
//				print(responseString)
//			}
//		}
//		
//	}
//}
//
//// MARK: Parse functions
//private static func parseToken(pResponseData: Any?) {
//	let responseData = pResponseData as! [String: AnyObject]
//	
//	user.setAccessToken(pAccessToken: responseData["access_token"] as! String)
//	user.setExpiresIn(pExpiresIn: responseData["expires_in"] as! Int)
//	user.setTokenType(pTokenType: responseData["token_type"] as! String)
//	user.setRefreshToken(pRefreshToken: responseData["refresh_token"] as! String)
//	
//	debugPrint("Parsed response data.")
//}
//
//// MARK: Debug functions
//public static func printArray() {
//	debugPrint("Printing array content..")
//	for Party in self.parties {
//		let partyVariable = Party.getPartyName()
//		debugPrint(partyVariable)
//	}
//}
//
//public static func postTestParty() {
//	let testParty = Party()
//	let testLocation = Location()
//	testParty.setLocation(pLocation: testLocation)
//	testParty.setPartyName(pPartyName: "iOS dummy party")
//	testParty.setPartyDate(pPartyDate: "2016-12-24T20:00:00.000Z")
//	testParty.setMusicGenre(pMusicGenre: MusicGenre.Mixed)
//	testParty.setPartyType(pPartyType: PartyType.Venue)
//	testParty.setDescription(pDescription: "string")
//	testLocation.setCountryName(pCountryName: "string")
//	testLocation.setCityName(pCityName: "string")
//	testLocation.setStreetName(pStreetName: "string")
//	testLocation.setHouseNumber(pHouseNumber: 0)
//	testLocation.setHouseNumberAdditional(pHouseNumberAdditional: "string")
//	testLocation.setZipcode(pZipcode: 0)
//	testLocation.setLatitude(pLatitude: 0)
//	testLocation.setLongitude(pLongitude: 0)
//	
//	postParty(pDictionary: testParty.toDictionary())
//}

//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 06.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

/*
import UIKit
import CoreData
import Alamofire

public class SwaggerCommunication {

public static func fetchParties(completionHandler: @escaping ([Party]?) -> ()) {
Alamofire.request(Properties.partyUrl, method: .get).validate().responseJSON { (response) in
// print response data
print("REQUEST URL:\n\(response.request as Any)")
print("HTTP URL RESPONSE:\n\(response.response as Any)")
print("SERVER DATA (BYTES):\n\(response.data as Any)")
print("RESULT OF SERIALIZATION:\n\(response.result as Any)")
print("VALUE OF THE RESULT:\n\(response.result.value as Any)")

// switch based on serialization result
switch response.result {
case .success:
print("SERIALIZATION SUCCESS.")
DispatchQueue.main.async(execute: { () -> Void in
completionHandler(CoreCommunication.parseParties(pData: (response.result.value)))
})
case .failure(let error):
print("SERIALIZATION FAILED.")
print(error)
}
}.resume()
}


}
*/

//
//  CoreCommunication.swift
//  App2Night
//
//  Created by Robin on 06.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

/*
import UIKit
import CoreData

public class CoreCommunication {

private static var partiesArray: [Party] = [Party]()

// parse json into core data
public static func parseParties(pData: Any?) -> [Party]? {
let partiesData = pData as! [[String: AnyObject]]

// core data
let delegate = UIApplication.shared.delegate as! AppDelegate
let context = delegate.getContext()

// for each party (dictionary) in partiesData
for Dictionary in partiesData {
// create core data objects
let party = Party(context: context)
let host = Host(context: context)
let location = Location(context: context)

// party
party.id = Dictionary["PartId"] as? String
party.price = Dictionary["Price"] as? String
party.name = Dictionary["PartyName"] as? String
party.date = Dictionary["PartyDate"] as? String
party.music = Dictionary["MusicGenre"] as? String
party.type = Dictionary["PartyType"] as? String
party.text = Dictionary["Description"] as? String

// location
location.country = Dictionary["Location"]!["CountryName"] as? String
location.city = Dictionary["Location"]!["CityName"] as? String
location.street = Dictionary["Location"]!["StreetName"] as? String
location.houseNum = Dictionary["Location"]!["HouseNumber"] as? String
location.houseNumExtra = Dictionary["Location"]!["HouseNumberAdditional"] as? String
location.zipcode = Dictionary["Location"]!["Zipcode"] as? String
location.latitude = Dictionary["Location"]!["Latitude"] as? String
location.longitude = Dictionary["Location"]!["Longitude"] as? String

// host
host.id = Dictionary["Host"]!["HostId"] as? String
host.user = Dictionary["Host"]!["UserName"] as? String

// relationships
party.location = location
party.host = host
location.party = party
host.addToParty(party)

do {
try(context.save())
} catch let e{
print(e)
}
}
self.loadParties()

return partiesArray
}

// load parties from core data
private static func loadParties() {
let delegate = UIApplication.shared.delegate as! AppDelegate
let fetchRequest:NSFetchRequest<Party> = Party.fetchRequest()

do {
let requestResults = try delegate.getContext().fetch(fetchRequest)
self.partiesArray = requestResults
} catch let e {
print(e)
}
}

// clear core data
public static func clearParties() {
let delegate = UIApplication.shared.delegate as! AppDelegate
let context = delegate.getContext()
let fetchRequest:NSFetchRequest<Party> = Party.fetchRequest()

do {
let requestResults = try delegate.getContext().fetch(fetchRequest)
for party in requestResults {
delegate.getContext().delete(party)
}

do {
try(context.save())
} catch let e{
print(e)
}
} catch let e {
print(e)
}
}

/*
// string to date
private static func dateWithString(pString: String) -> Date {
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
let dateConverted = dateFormatter.date(from: pString)

return dateConverted!
}

// string to decimal
private static func decimalWithString(pString: String) -> NSDecimalNumber {
let numberFormatter = NumberFormatter()
numberFormatter.generatesDecimalNumbers = true
return numberFormatter.number(from: pString) as? NSDecimalNumber ?? 0
}
*/

}
*/


