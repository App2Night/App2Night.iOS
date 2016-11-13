//
//  PartyTableController.swift
//  App2Night
//
//  Created by Robin on 07.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import RealmSwift

class PartyTableViewController: UITableViewController {
	
	let realm = try! Realm()
	var results = try! Realm().objects(Party.self)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.refreshControl?.addTarget(self, action: #selector(PartyTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
	}
	
	func handleRefresh(_ refreshControl: UIRefreshControl) {
		SwaggerCommunication.getParties { results in
			self.results = results
			self.tableView.reloadData()
			refreshControl.endRefreshing()
		}
	}
	
	// MARK: - table view cell setup
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return results.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell", for: indexPath) as! PartyTableViewCell
		
		let object = results[indexPath.row]
		cell.partyName?.text = object.name
		cell.partyText?.text = object.text
		cell.partyLabel?.text = object.location?.cityName
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

