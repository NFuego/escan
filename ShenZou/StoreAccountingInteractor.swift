//
//  StoreAccountingInteractor.swift
//  Project: EscanTest
//
//  Module: StoreAccounting
//
//  By zcon 2017/4/19
//  zcon 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `StoreAccountingInteractor` and referenced by `StoreAccountingPresenter`
protocol StoreAccountingPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the StoreAccounting module
final class StoreAccountingInteractor {

	// MARK: - Variables
	weak var presenter: StoreAccountingInteractorPresenterProtocol?
}

// MARK: - StoreAccounting Presenter to Interactor Protocol

extension StoreAccountingInteractor: StoreAccountingPresenterInteractorProtocol {
	func requestTitle() {
		presenter?.set(title: nslAccounting)
	}
}
