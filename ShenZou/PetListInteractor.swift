//
//  PetListInteractor.swift
//  Project: EscanTest
//
//  Module: PetList
//
//  By zcon 2017/4/6
//  zcon 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `PetListInteractor` and referenced by `PetListPresenter`
protocol PetListPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the PetList module
final class PetListInteractor {

	// MARK: - Variables

	weak var presenter: PetListInteractorPresenterProtocol?
}

// MARK: - PetList Presenter to Interactor Protocol

extension PetListInteractor: PetListPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "PetList")
	}
}
