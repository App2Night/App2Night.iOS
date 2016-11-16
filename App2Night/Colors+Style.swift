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
	
	// misc
	static var a2nWhite: UIColor { get { return UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0) } }
	
	
}

// static struct to define UI themes - source: http://sdbr.net/post/Themes-in-Swift/
struct Style {
	
	/*
	static var sectionHeaderTitleFont = UIFont(name: "Helvetica-Bold", size: 20)
	static var sectionHeaderTitleColor = UIColor.whiteColor()
	static var sectionHeaderBackgroundColor = UIColor.blackColor()
	static var sectionHeaderBackgroundColorHighlighted = UIColor.grayColor()
	static var sectionHeaderAlpha: CGFloat = 1.0
	
	static func themeBlue(){
		// MARK: ToDo Table Section Headers
		sectionHeaderTitleFont = UIFont(name: "Helvetica", size: 18)
		sectionHeaderTitleColor = UIColor.whiteColor()
		sectionHeaderBackgroundColor = UIColor.blueColor()
		sectionHeaderBackgroundColorHighlighted = UIColor.lightGrayColor()
		sectionHeaderAlpha: CGFloat = 0.8
	}
	*/
	
	
}

