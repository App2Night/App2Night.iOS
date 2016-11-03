//
//  User.swift
//  App2Night
//
//  Created by Robin on 31.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

public class User {
	
	private var userId: String!
	private var userName: String!
	private var password: String!
	private var accessToken: String!
	private var expiresIn: Int!
	private var tokenType: String!
	private var refreshToken: String!
	
	
	// MARK: init empty user object
	init() {
		
	}

	// MARK: GET & SET
	public func getUserID() -> String {
		return self.userId
	}
	
	public func setUserID(pUserID: String) {
		self.userId = pUserID
	}
	
	public func getUserName() -> String {
		return self.userName
	}
	
	public func setUserName(pUserName: String) {
		self.userName = pUserName
	}
	
	public func getPassword() -> String {
		return self.password
	}
	
	public func setPassword(pPassword: String) {
		self.password = pPassword
	}
	
	public func getAccessToken() -> String {
		return self.accessToken
	}
	
	public func setAccessToken(pAccessToken: String) {
		self.accessToken = pAccessToken
	}
	
	public func getExpiresIn() -> Int {
		return self.expiresIn
	}
	
	public func setExpiresIn(pExpiresIn: Int) {
		self.expiresIn = pExpiresIn
	}
	
	public func getTokenType() -> String {
		return self.tokenType
	}
	
	public func setTokenType(pTokenType: String) {
		self.tokenType = pTokenType
	}
	
	public func getRefreshToken() -> String {
		return self.refreshToken
	}
	
	public func setRefreshToken(pRefreshToken: String) {
		self.refreshToken = pRefreshToken
	}
	
	
}

