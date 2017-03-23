//
//  ManualAccountingRouter.swift
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

// MARK: Protocols

/// Should be conformed to by the `ManualAccountingRouter` and referenced by `ManualAccountingPresenter`
protocol ManualAccountingPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the ManualAccounting module
final class ManualAccountingRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension ManualAccountingRouter: RouterProtocol {

}

// MARK: ManualAccounting Presenter to Router Protocol

extension ManualAccountingRouter: ManualAccountingPresenterRouterProtocol {

}
