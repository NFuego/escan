

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ManualAccountingPresenter` and referenced by `ManualAccountingViewController`
protocol ManualAccountingViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `ManualAccountingPresenter` and referenced by `ManualAccountingInteractor`
protocol ManualAccountingInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the ManualAccounting module
final class ManualAccountingPresenter {

	// MARK: - Constants

	let router: ManualAccountingPresenterRouterProtocol
	let interactor: ManualAccountingPresenterInteractorProtocol

	// MARK: Variables

	weak var view: ManualAccountingPresenterViewProtocol?

	// MARK: Inits

	init(router: ManualAccountingPresenterRouterProtocol, interactor: ManualAccountingPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - ManualAccounting View to Presenter Protocol

extension ManualAccountingPresenter: ManualAccountingViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: ManualAccounting Interactor to Presenter Protocol

extension ManualAccountingPresenter: ManualAccountingInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
