//
//  AppDelegate.swift
//  App2Night
//
//  Created by Robin on 22.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		setupViews()
		
		return true
	}
	
	func setupViews() {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		
		// root tab bar controller
		let partyTabBarController = PartyTabBarController()
		
		// tab views embedded in navigation controllers
		let partyTableViewController = PartyNavigationController(rootViewController: PartyCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout()))
		partyTableViewController.tabBarItem = UITabBarItem(title: "Parties", image: #imageLiteral(resourceName: "Party Baloons"), selectedImage: #imageLiteral(resourceName: "Party Baloons Filled"))
		
		let partyMapViewController = PartyNavigationController(rootViewController: PartyMapViewController())
		partyMapViewController.tabBarItem = UITabBarItem(title: "Karte", image: #imageLiteral(resourceName: "Map"), selectedImage: #imageLiteral(resourceName: "Map Filled"))
		
		let partyUserProfileViewController = PartyNavigationController(rootViewController: PartyUserProfileViewController(style: .grouped))
		partyUserProfileViewController.tabBarItem = UITabBarItem(title: "Profil", image: #imageLiteral(resourceName: "Circled User Male"), selectedImage: #imageLiteral(resourceName: "Circled User Male Filled"))
		
		// add tab views to tab bar controller
		let tabViews = [partyTableViewController, partyMapViewController, partyUserProfileViewController]
		partyTabBarController.viewControllers = tabViews
		
		// set root view to tab bar controller
		window?.rootViewController = partyTabBarController
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	
}

