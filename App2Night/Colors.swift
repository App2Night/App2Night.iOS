//
//  Colors.swift
//  App2Night
//
//  Created by Robin on 11.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

extension UIColor {
	
	convenience init(red: Int, green: Int, blue: Int) {
		let fRed = CGFloat(red)/255
		let fGreen = CGFloat(green)/255
		let fBlue = CGFloat(blue)/255
		
		self.init(red: fRed, green: fGreen, blue: fBlue, alpha: 1.0)
	}
	
	
}

class Colors {
	
	public static let darkBlue = UIColor(red: 0, green: 38, blue: 53)
	public static let highlightBlue = UIColor(red: 1, green: 52, blue: 61)
	public static let red = UIColor(red: 171, green: 26, blue: 37)
	public static let orange = UIColor(red: 217, green: 121, blue: 37)
	public static let white = UIColor(red: 242, green: 242, blue: 242)
	public static let clear = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
	
	
}

