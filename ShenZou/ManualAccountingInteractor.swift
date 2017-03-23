//
//  ManualAccountingInteractor.swift
//  Project: SuccessfulOrigami
//
//  Module: ManualAccounting
//
//  By zcon 2017/3/23
//  zcon 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ManualAccountingInteractor` and referenced by `ManualAccountingPresenter`
protocol ManualAccountingPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the ManualAccounting module
final class ManualAccountingInteractor {

	// MARK: - Variables

	weak var presenter: ManualAccountingInteractorPresenterProtocol?
}

// MARK: - ManualAccounting Presenter to Interactor Protocol

extension ManualAccountingInteractor: ManualAccountingPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "ManualAccounting")
	}
}
