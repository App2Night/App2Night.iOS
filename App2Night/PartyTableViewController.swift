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
	
	var partiesArray: [Party]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let realm = try! Realm()
		
		/*
		RealmCommunication.clear()
		
		SwaggerCommunication.getParties { response in
		self.partiesArray = response
		self.tableView.reloadData()
		RealmCommunication.printRealmUrl()
		}
		*/
		
		self.partiesArray = Array(realm.objects(Party.self))
		
		/*
		RealmCommunication.clear()
		
		SwaggerCommunication.getParties { (parties) in
		self.partiesArray = parties!
		self.tableView.reloadData()
		RealmCommunication.printRealmUrl()
		}
		*/
	}
	
	// MARK: - table view cell setup
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return partiesArray?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell", for: indexPath) as! PartyTableViewCell
		
		cell.partyName.text = self.partiesArray?[indexPath.row].name
		cell.partyText.text = self.partiesArray?[indexPath.row].text
		cell.partyLabel.text = ((self.partiesArray?[indexPath.row].location)! as Location).cityName + " • " + ((self.partiesArray?[indexPath.row].price)! as Int).description + " €"
		cell.partyDistance.text = "15"
		
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

