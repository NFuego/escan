//
//  ManualAccountingModule.swift
//  Project: SuccessfulOrigami
//
//  Module: ManualAccounting
//
//  By zcon 2017/3/23
//  zcon 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the ManualAccounting VIPER module
final class ManualAccountingModule {

	// MARK: - Variables

	private(set) lazy var interactor: ManualAccountingInteractor = {
		return ManualAccountingInteractor()
	}()

	private(set) lazy var router: ManualAccountingRouter = {
		return ManualAccountingRouter()
	}()

	private(set) lazy var presenter: ManualAccountingPresenter = {
		return ManualAccountingPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: ManualAccountingViewController = {
		return ManualAccountingViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension ManualAccountingModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
