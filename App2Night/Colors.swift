//
//  Colors.swift
//  App2Night
//
//  Created by Robin on 11.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

// extend UIColor class with App2Night colors
extension UIColor {
	
	// logo colors
	static var a2nDarkBlue: UIColor { get { return UIColor(red: 0/255, green: 38/255, blue: 53/255, alpha: 1.0) } }
	static var a2nHighlightBlue: UIColor { get { return UIColor(red: 1/255, green: 52/255, blue: 61/255, alpha: 1.0) } }
	static var a2nRed: UIColor { get { return UIColor(red: 171/255, green: 26/255, blue: 37/255, alpha: 1.0) } }
	static var a2nOrange: UIColor { get { return UIColor(red: 217/255, green: 121/255, blue: 37/255, alpha: 1.0) } }
	
	// ui colors
	static var a2nLightGray: UIColor { get { return UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0) } }
	static var a2nGray: UIColor { get { return UIColor(red: 200/255, green: 199/255, blue: 204/255, alpha: 1.0) } }
	
}
