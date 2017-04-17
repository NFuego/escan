
// MARK: Imports
import UIKit
import Eureka
import SwiftyVIPER
import Kingfisher

// MARK: Protocols

/// Should be conformed to by the `ContactViewInteractor` and referenced by `ContactViewPresenter`
protocol ContactViewPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)

}

// MARK: -

/// The View Controller for the ContactView module
class ContactViewViewController: FormViewController {

	// MARK: - Constants
	let presenter: ContactViewViewPresenterProtocol
	// MARK: Variables

	// MARK: Inits
	init(presenter: ContactViewViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions

	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()

		view.backgroundColor = .white
        setupForm()
    }
} // fin ContactViewViewController

// MARK: - ContactView Presenter to View Protocol
extension ContactViewViewController: ContactViewPresenterViewProtocol {
	func set(title: String?) {
		self.title = title
	}
}

let kName = NSLocalizedString("name", comment: "")
let kPhone = NSLocalizedString("phone", comment: "")
let kEmail = NSLocalizedString("email", comment: "")
let kAddress = NSLocalizedString("adress", comment: "")
let kPhoto = NSLocalizedString("photo", comment: "")
let kHeader = NSLocalizedString("header", comment: "")

extension ContactViewViewController {
    func setupForm(){
        form +++ Section(header: kHeader, footer: "")
        // ========================================================================== loaded zone
        <<< ImgRow() { (i:ImgRow) -> Void in
            i.tag = kPhoto
//          i.value = Picture(url: url)
        }.onChange({ (i:ImgRow) in
//                        print("here")
//                        print(i.value?.url)
        })
        <<< LabelRow() { (l:LabelRow) -> Void in
            l.title = kName
            l.tag = kName
        }
        <<< LabelRow() { (l:LabelRow) -> Void in
            l.title = kPhone
            l.tag = kPhone
        }
        <<< LabelRow() { (l:LabelRow) -> Void in
            l.title = kEmail
            l.tag = kEmail
        }
        <<< LabelRow() { (l:LabelRow) -> Void in
            l.title = kAddress
            l.tag = kAddress
        }
    } // fin setupForm
}

