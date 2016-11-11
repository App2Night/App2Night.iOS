//
//  PartyTableViewController.swift
//  App2Night
//
//  Created by Tobias Müller on 03.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import RealmSwift

class PartyTableViewController: UITableViewController {
	
	var partiesArray: [Party] = [Party]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		RealmCommunication.delete()
		
		let realm = try! Realm()
		let store = RealmCommunication()
		
		store.clear(realm: realm)
		
		SwaggerCommunication.getParties { () in
			self.partiesArray = Array(realm.objects(Party.self))
			self.tableView.reloadData()
			print(realm.configuration.fileURL!)
		}
		
		// self.partiesArray = Array(realm.objects(Party.self))
		
		/*
		let firstParty = store.createDummy()
		
		try! realm.write {
			realm.add(firstParty)
		}
		
		self.partiesArray = Array(realm.objects(Party.self))
		*/
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Anzahl der Tabellen-Cellen untereinander
		return partiesArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PartyTableViewCell", for: indexPath) as! PartyTableViewCell
		// Configure the cell...
		cell.Distance.text = "0"
		cell.PartyLocation.text = (self.partiesArray[indexPath.row].location! as Location).cityName
		cell.PartyName.text = self.partiesArray[indexPath.row].name
		
		return cell
	}
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
	if editingStyle == .delete {
	// Delete the row from the data source
	tableView.deleteRows(at: [indexPath], with: .fade)
	} else if editingStyle == .insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}

class PartyTableViewCell: UITableViewCell {
	
	//MARK: Properties
	@IBOutlet weak var PartyName: UILabel!
	@IBOutlet weak var PartyLocation: UILabel!
	@IBOutlet weak var Distance: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}

