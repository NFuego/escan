//
//  PetListModule.swift
//  Project: EscanTest
//
//  Module: PetList
//
//  By zcon 2017/4/6
//  zcon 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the PetList VIPER module
final class PetListModule {

	// MARK: - Variables

	private(set) lazy var interactor: PetListInteractor = {
		return PetListInteractor()
	}()

	private(set) lazy var router: PetListRouter = {
		return PetListRouter()
	}()

	private(set) lazy var presenter: PetListPresenter = {
		return PetListPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: PetListViewController = {
		return PetListViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension PetListModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
