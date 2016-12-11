//
//  LoginViewController.swift
//  App2Night
//
//  Created by Robin on 05.12.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
	
	func finishLoggingIn()
	func dismissKeyboard()
	func displayAlert(title: String, message: String, buttonTitle: String)
	
}

class LoginViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LoginViewControllerDelegate {
	
	// fancy pages
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.backgroundColor = .white
		view.dataSource = self
		view.delegate = self
		view.isPagingEnabled = true
		view.bounces = false
		view.showsHorizontalScrollIndicator = false
		return view
	}()
	
	let pageControl: UIPageControl = {
		let control = UIPageControl()
		control.pageIndicatorTintColor = .lightGray
		control.currentPageIndicatorTintColor = .a2nRed
		control.numberOfPages = 2
		control.isUserInteractionEnabled = false
		return control
	}()
	
	let loginCellId = "LoginViewCell"
	let registerCellId = "RegisterViewCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.hideKeyboardWhenTappedAround()
		
		observeKeyboard()
		
		// add collectionview to view and snap to corners
		view.addSubview(collectionView)
		collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
		
		// page controller
		view.addSubview(pageControl)
		
		_ = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
		
		// register cells
		collectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: loginCellId)
		collectionView.register(RegisterCollectionViewCell.self, forCellWithReuseIdentifier: registerCellId)
	}
	
	func finishLoggingIn() {
		UserDefaults.standard.setIsLoggedIn(value: true)
		dismiss(animated: true, completion: nil)
	}
	
	// is keyboard shown?
	fileprivate func observeKeyboard() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
	}
	
	func keyboardHide() {
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
			
			self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
			
		}, completion: nil)
	}
	
	func keyboardShow() {
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
			
			if (self.pageControl.currentPage == 0) {
				self.view.frame = CGRect(x: 0, y: -140, width: self.view.frame.width, height: self.view.frame.height)
			} else {
				self.view.frame = CGRect(x: 0, y: -166, width: self.view.frame.width, height: self.view.frame.height)
			}
			
		}, completion: nil)
	}
	
	// dismiss keyboard if you scroll
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		view.endEditing(true)
	}
	
	// set current page number
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		// calculate current page number based on scroll distance in x
		let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
		pageControl.currentPage = pageNumber
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch (indexPath.item) {
		case 0:
			let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCollectionViewCell
			loginCell.delegate = self
			return loginCell
		case 1:
			let registerCell = collectionView.dequeueReusableCell(withReuseIdentifier: registerCellId, for: indexPath) as! RegisterCollectionViewCell
			registerCell.delegate = self
			return registerCell
		default: fatalError("More than 2 pages in collectionView")
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: view.frame.height)
	}
	
	// alert controllers
	func displayAlert(title: String, message: String, buttonTitle: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
		alert.addAction(defaultAction)
		self.present(alert, animated: true, completion: nil)
	}
}

