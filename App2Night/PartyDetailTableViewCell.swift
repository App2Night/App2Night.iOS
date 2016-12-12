//
//  PartyDetailTableViewCell.swift
//  App2Night
//
//  Created by Robin on 11.12.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

extension PartyDetailTableViewController {
	
	class BaseCell: UITableViewCell {
		
		override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
			setupCell()
		}
		
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
		func setupCell() {
			
		}
		
	}

}

