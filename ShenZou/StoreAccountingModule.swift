//
//  StoreAccountingModule.swift
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

// MARK: -

/// Used to initialize the StoreAccounting VIPER module
final class StoreAccountingModule {

	// MARK: - Variables

	private(set) lazy var interactor: StoreAccountingInteractor = {
		return StoreAccountingInteractor()
	}()

	private(set) lazy var router: StoreAccountingRouter = {
		return StoreAccountingRouter()
	}()

	private(set) lazy var presenter: StoreAccountingPresenter = {
		return StoreAccountingPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: StoreAccountingViewController = {
		return StoreAccountingViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension StoreAccountingModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
