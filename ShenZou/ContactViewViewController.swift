//
//  ContactViewViewController.swift
//  Project: EscanTest
//
//  Module: ContactView
//
//  By zcon 2017/4/5
//  zcon 2017年
//

// MARK: Imports

import UIKit
import Eureka
import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ContactViewInteractor` and referenced by `ContactViewPresenter`
protocol ContactViewPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the ContactView module
class ContactViewViewController: FormViewController {

	// MARK: - Constants
	let presenter: ContactViewViewPresenterProtocol

	// MARK: Variables

	// MARK: Inits

	init(presenter: ContactViewViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions

	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()

		view.backgroundColor = .white
        setupForm()
    }
}

// MARK: - ContactView Presenter to View Protocol

extension ContactViewViewController: ContactViewPresenterViewProtocol {
	func set(title: String?) {
		self.title = title
	}
}

extension ContactViewViewController {
    func setupForm(){
        let header = NSLocalizedString("header", comment: "")
        let name = NSLocalizedString("name", comment: "")
        form +++ Section(header: header, footer: "")
            // ========================================================================== loaded zone
            <<< LabelRow() { (l:LabelRow) -> Void in
                l.title = name
                l.value = "test"
            }
    } // fin setupForm
}
