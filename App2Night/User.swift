//
//  User.swift
//  App2Night
//
//  Created by Robin on 31.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

public class User {
	
	private var accessToken: String!
	private var expiresIn: Int!
	private var tokenType: String!
	private var refreshToken: String!
	
	
	// MARK: init empty user object
	init() {
		
	}
	
	// MARK: GET & SET
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

