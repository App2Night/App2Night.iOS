//
//  PartyTableViewController.swift
//  App2Night
//
//  Created by Robin on 07.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import RealmSwift

class PartyTableViewController: UITableViewController {
	
	// get parties from realm
	var parties = try! Realm().objects(Party.self)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		PositionManager.shared.getPosition()
		
		self.refreshControl?.addTarget(self, action: #selector(PartyTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
	}
	
	func handleRefresh(_ refreshControl: UIRefreshControl) {
		SwaggerCommunication.shared.getParties { success in
			if success {
				self.parties = try! Realm().objects(Party.self)
				self.tableView.reloadData()
				refreshControl.endRefreshing()
			} else {
				refreshControl.endRefreshing()
			}
		}
	}
	
	@IBAction func clearTableButton(_ sender: Any) {
		RealmManager.shared.clear()
		self.tableView.reloadData()
	}
	
	// MARK: - table view cell setup
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return parties.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell", for: indexPath) as! PartyTableViewCell
		
		let object = parties[indexPath.row]
		cell.partyName?.text = object.name
		cell.partyText?.text = object.text
		cell.partyLabel?.text = object.cityName
		cell.partyDistance?.text = "99"
		
		return cell
	}
	
	
}

class PartyTableViewCell: UITableViewCell {
	
	@IBOutlet weak var partyName: UILabel!
	@IBOutlet weak var partyText: UILabel!
	@IBOutlet weak var partyLabel: UILabel!
	@IBOutlet weak var partyDistance: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	
}

