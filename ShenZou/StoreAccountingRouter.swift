//
//  StoreAccountingRouter.swift
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

/// Should be conformed to by the `StoreAccountingRouter` and referenced by `StoreAccountingPresenter`
protocol StoreAccountingPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the StoreAccounting module
final class StoreAccountingRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension StoreAccountingRouter: RouterProtocol {

}

// MARK: StoreAccounting Presenter to Router Protocol

extension StoreAccountingRouter: StoreAccountingPresenterRouterProtocol {

}
