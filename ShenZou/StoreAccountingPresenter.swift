//
//  StoreAccountingPresenter.swift
//  Project: EscanTest
//
//  Module: StoreAccounting
//
//  By zcon 2017/4/19
//  zcon 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `StoreAccountingPresenter` and referenced by `StoreAccountingViewController`
protocol StoreAccountingViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `StoreAccountingPresenter` and referenced by `StoreAccountingInteractor`
protocol StoreAccountingInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the StoreAccounting module
final class StoreAccountingPresenter {

	// MARK: - Constants
	let router: StoreAccountingPresenterRouterProtocol
	let interactor: StoreAccountingPresenterInteractorProtocol

	// MARK: Variables
	weak var view: StoreAccountingPresenterViewProtocol?

	// MARK: Inits

	init(router: StoreAccountingPresenterRouterProtocol, interactor: StoreAccountingPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - StoreAccounting View to Presenter Protocol

extension StoreAccountingPresenter: StoreAccountingViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: StoreAccounting Interactor to Presenter Protocol

extension StoreAccountingPresenter: StoreAccountingInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
